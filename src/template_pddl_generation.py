import csv
import re
import os

###############################################################################
# 1) READING FROM CSV
###############################################################################
def extract_between_asterisks(text):
    """
    Extract the first expression between two asterisks (* ... *).
    For example, if text = 'some *value* here', returns 'value'.
    """
    match = re.search(r'\*(.*?)\*', text)
    return match.group(1) if match else ""

###############################################################################
# 2) PRE-PROCESSING TO HANDLE MULTIPLE FORMATS (Optional/Example)
###############################################################################
def preprocess_q5_text(raw_text):
    """
    If you have multiple formats (A, B, C, D...), unify them here.
    For brevity, we'll assume everything is already close to:
      - **ActionName**: **Duration** - **Outcome**
    Or it might be minimal transformation logic.

    Expand this as needed when you discover new formats.
    """
    # For demonstration, we just strip trailing whitespace.
    # Real logic would detect Format D, etc., and convert it.
    return raw_text.strip()

###############################################################################
# 3) PARSE THE CANONICAL FORMAT
###############################################################################
def parse_q5_result(unified_text):
    """
    We expect lines of the form:
      - **ActionName**: **Duration** - **Outcome**
    Where there are exactly 3 double-asterisk groups:
      1) Action name
      2) Duration
      3) Outcome
    If duration is missing or unknown, e.g.:
      - **Post-mission data analysis**: **unknown** - **failure**
    We'll still see 3 groups in **...**.

    Returns a list of dicts:
      [
        {
          'action_name': str,
          'action_duration': str,
          'action_outcome': str
        },
        ...
      ]
    """
    lines = unified_text.split('\n')
    actions = []
    for line in lines:
        line = line.strip()
        if not line.startswith('- '):
            continue
        # Grab text between **...** groups
        matches = re.findall(r'\*\*(.*?)\*\*', line)
        if len(matches) == 3:
            action_dict = {
                'action_name': matches[0].strip(),
                'action_duration': matches[1].strip(),
                'action_outcome': matches[2].strip()
            }
            actions.append(action_dict)
        else:
            # Could handle partial matches or fallback logic
            pass
    return actions

###############################################################################
# 3b) PARSE NOAA MULTI-SECTION FORMAT
###############################################################################
_NOAA_META_PREFIXES = (
    'duration', 'success', 'result', 'outcome', 'status', 'failure', 'time',
)

def _noaa_looks_like_metadata(s):
    s = s.lower().strip().lstrip('*').strip()
    return s.startswith(_NOAA_META_PREFIXES)

def _noaa_normalize_task_key(s):
    s = s.lower().strip()
    s = re.sub(r'[^\w\s]', ' ', s)
    s = re.sub(r'\s+', ' ', s).strip()
    s = re.sub(
        r'^(a|an|the|conduct|conducting|perform|performing|complete|completing|'
        r'continue|continuing|testing|test|deploy|deploying|develop|developing)\s+',
        '', s,
    )
    return s.strip()

def _noaa_split_sections(text):
    """
    Locate 'Tasks', 'Duration', and 'Success/Outcome/Result' section headers
    and return the text under each.
    """
    header_specs = [
        ('tasks',    r'(?:existing\s+)?tasks?(?:\s+(?:involved\s+)?in(?:volved)?(?:\s+this|\s+the)?\s+mission)?(?:\s+for\s+the\s+mission)?'),
        ('duration', r'durations?(?:\s+of(?:\s+each)?\s+tasks?)?'),
        ('outcome',  r'(?:success(?:\s*/\s*failure)?(?:\s+of(?:\s+each)?\s+tasks?)?|outcomes?|results?|success\s+status)'),
    ]
    positions = []
    for key, pat in header_specs:
        regex = re.compile(rf'(?im)(?:^|\n)[\s*]*{pat}\s*:\s*\**', re.IGNORECASE)
        for m in regex.finditer(text):
            positions.append((m.start(), m.end(), key))
    positions.sort()
    sections = {}
    for i, (_, end, key) in enumerate(positions):
        next_start = positions[i + 1][0] if i + 1 < len(positions) else len(text)
        content = text[end:next_start].strip()
        if key not in sections or len(content) > len(sections[key]):
            sections[key] = content
    return sections

def _noaa_extract_task_list(section_text):
    if not section_text:
        return []
    t = re.sub(r'\s+', ' ', section_text).strip().strip('*').strip()
    if t and not t[0].isspace():
        t = ' ' + t
    parts = re.split(r'\s+[-•]\s+', t)
    tasks = []
    for p in parts:
        p = p.strip().strip('*').strip().lstrip('-•').strip().rstrip(':.,;').strip()
        if not p or len(p) < 3:
            continue
        if _noaa_looks_like_metadata(p):
            continue
        tasks.append(p)
    return tasks

def _noaa_extract_keyed_map(section_text):
    if not section_text:
        return {}
    result = {}
    for line in section_text.split('\n'):
        line = line.strip().strip('*').strip()
        if not line:
            continue
        m = re.match(r'^([^:]+?):\s*(.+?)\s*$', line)
        if m:
            key = m.group(1).strip().strip('*').strip().lower()
            val = m.group(2).strip().strip('*').strip().rstrip('.,;:')
            if key and val and not _noaa_looks_like_metadata(key):
                result[key] = val
    return result

_NOAA_STOP = {
    'a', 'an', 'the', 'of', 'and', 'or', 'with', 'in', 'on', 'at', 'to',
    'for', 'by', 'from', 'this', 'that', 'is', 'are', 'each', 'its', 'it',
}

def _noaa_tokens(s):
    return set(_noaa_normalize_task_key(s).split()) - _NOAA_STOP

def _noaa_match_value(task, keyed_map, threshold=0.5):
    if not keyed_map:
        return None
    t_tokens = _noaa_tokens(task)
    if not t_tokens:
        return None
    best_val = None
    best_score = 0.0
    for k, v in keyed_map.items():
        k_tokens = _noaa_tokens(k)
        if not k_tokens:
            continue
        inter = len(t_tokens & k_tokens)
        if not inter:
            continue
        union = len(t_tokens | k_tokens)
        jaccard = inter / union
        containment = inter / min(len(t_tokens), len(k_tokens))
        score = max(jaccard, containment)
        if score > best_score:
            best_score = score
            best_val = v
    return best_val if best_score >= threshold else None

def _noaa_parse_per_task_blocks(text):
    """
    Pattern:
      - Task A
          Duration: X
          Result: Y
    """
    actions = []
    current = {'action_name': None, 'action_duration': '', 'action_outcome': ''}

    def flush():
        if current['action_name']:
            actions.append({
                'action_name': current['action_name'],
                'action_duration': current['action_duration'] or 'Unknown',
                'action_outcome': current['action_outcome'] or 'Unknown',
            })
        current['action_name'] = None
        current['action_duration'] = ''
        current['action_outcome'] = ''

    for line in text.split('\n'):
        s = line.strip().strip('*').strip()
        if not s:
            continue
        m_dur = re.match(r'(?i)^(duration|time)\s*[:\-]\s*(.+)$', s)
        m_out = re.match(r'(?i)^(result|outcome|success|status|success\s*/\s*failure|failure)\s*[:\-]\s*(.+)$', s)
        m_task = re.match(r'^[-•*]\s+(.+)$', line.strip())
        if m_dur and current['action_name']:
            current['action_duration'] = m_dur.group(2).strip().strip('*').strip().rstrip('.,;')
        elif m_out and current['action_name']:
            current['action_outcome'] = m_out.group(2).strip().strip('*').strip().rstrip('.,;')
        elif m_task:
            candidate = m_task.group(1).strip().strip('*').strip().rstrip(':').strip()
            if not _noaa_looks_like_metadata(candidate) and len(candidate) > 2:
                flush()
                current['action_name'] = candidate
    flush()
    return actions

def parse_noaa_q5_result(unified_text):
    """
    NOAA-specific parser. Tries, in order:
      1) Canonical inline format (delegates to parse_q5_result)
      2) Per-task-block format (task bullet followed by Duration/Result lines)
      3) Multi-section format (Tasks / Duration / Success-Result sections)
    Returns a list of {action_name, action_duration, action_outcome} dicts.
    """
    if not unified_text or not unified_text.strip():
        return []
    text = unified_text.strip()

    actions = parse_q5_result(text)
    if actions:
        return actions

    actions = _noaa_parse_per_task_blocks(text)
    if actions:
        return actions

    sections = _noaa_split_sections(text)
    tasks = _noaa_extract_task_list(sections.get('tasks', ''))
    durs = _noaa_extract_keyed_map(sections.get('duration', ''))
    outs = _noaa_extract_keyed_map(sections.get('outcome', ''))
    if not tasks:
        return []
    return [
        {
            'action_name': t,
            'action_duration': _noaa_match_value(t, durs) or 'Unknown',
            'action_outcome': _noaa_match_value(t, outs) or 'Unknown',
        }
        for t in tasks
    ]

###############################################################################
# 4) LOGIC: DURATIVE vs NON-DURATIVE
###############################################################################
def get_pddl_action_type(action_duration):
    """
    Decide whether to create a durative-action or a normal :action.
    If duration is 'Unknown', 'Unspecified', empty, etc., return 'action'.
    Otherwise 'durative-action'.
    """
    if not action_duration:
        return "action"
    duration_lower = action_duration.lower()
    if duration_lower in ("unknown", "unspecified", "none", ""):
        return "action"
    # Otherwise we assume we have a numeric or parseable duration
    return "durative-action"

def convert_to_decimal(time_str):
    """
    Convert a duration string like '3 hours and 15 minutes' to a float.
    """
    if not time_str:
        return 0.0

    hours = 0
    minutes = 0

    hour_match = re.search(r'(\d+)\s*hour', time_str, re.IGNORECASE)
    if hour_match:
        hours = int(hour_match.group(1))

    minute_match = re.search(r'(\d+)\s*min', time_str, re.IGNORECASE)
    if minute_match:
        minutes = int(minute_match.group(1))

    return hours + minutes / 60.0

###############################################################################
# 5) TYPE INFERENCE (OPTIONAL)
###############################################################################
TYPE_TO_VAR = {
    "survey": "?s",
    "ctd": "?i",
    "mission": "?m",
    # Add more if needed
}

def infer_types_from_action_name(name):
    """
    Very naive approach: if 'mission' in name, add type 'mission', etc.
    """
    name_lower = name.lower()
    inferred = []
    if "survey" in name_lower:
        inferred.append("survey")
    if "ctd" in name_lower:
        inferred.append("ctd")
    if "mission" in name_lower:
        inferred.append("mission")
    return inferred

###############################################################################
# 6) BUILDING PDDL ACTIONS
###############################################################################
def generate_pddl_action(action):
    """
    Convert a single action dictionary into either a durative-action
    or a non-durative :action, depending on the duration.

    action = {
      'action_name': str,
      'action_duration': str,
      'action_outcome': str,
      'action_types': list[str]
    }
    """
    aname = action['action_name'].replace(' ', '_').lower()
    outcome = action['action_outcome'].lower().replace(' ', '_')
    aduration_str = action['action_duration']
    action_type = get_pddl_action_type(aduration_str)

    # Build typed parameters
    typed_params = []
    for t in action.get('action_types', []):
        var_name = TYPE_TO_VAR.get(t, "?x")
        typed_params.append(f"{var_name} - {t}")
    parameters_str = "(" + " ".join(typed_params) + ")" if typed_params else "()"

    if action_type == "durative-action":
        # Parse numeric duration
        dur_value = convert_to_decimal(aduration_str)
        return f"""
  (:durative-action {aname}
    :parameters {parameters_str}
    :duration (= ?duration {dur_value})
    :condition (and
      (at start (precondition_for_{outcome}))
    )
    :effect (and
      (at end (outcome_{outcome}))
    )
  )
"""
    else:
        # Non-durative action
        return f"""
  (:action {aname}
    :parameters {parameters_str}
    :precondition (and
      (precondition_for_{outcome})
    )
    :effect (and
      (outcome_{outcome})
    )
  )
"""

###############################################################################
# 7) OUTCOME-BASED PREDICATES
###############################################################################
def generate_predicates_for_outcomes(actions):
    """
    Auto-generate (precondition_for_<outcome>) and (outcome_<outcome>)
    for each distinct outcome in actions.
    """
    outcomes = set()
    for a in actions:
        out = a['action_outcome'].lower().replace(' ', '_')
        outcomes.add(out)
    lines = []
    for o in sorted(outcomes):
        lines.append(f"(precondition_for_{o})")
        lines.append(f"(outcome_{o})")
    return "\n    ".join(lines)

###############################################################################
# 8) BUILDING THE FULL DOMAIN
###############################################################################
def create_pddl_domain(domain_name, user_predicates, actions):
    """
    - Turn each action dict into PDDL code (either :durative-action or :action).
    - Gather distinct types, build the (:types ...) block.
    - Merge user-supplied predicates with outcome-based predicates.
    """
    # 1) Infer types + build action strings
    pddl_actions = []
    distinct_types = set()
    for a in actions:
        a['action_types'] = infer_types_from_action_name(a['action_name'])
        for t in a['action_types']:
            distinct_types.add(t)
        action_str = generate_pddl_action(a)
        pddl_actions.append(action_str)

    # 2) Auto-generate outcome predicates
    outcome_preds = generate_predicates_for_outcomes(actions)

    # 3) Combine user_predicates + outcome_preds
    user_predicates = user_predicates.strip()
    if user_predicates:
        user_preds_indented = "\n    ".join(user_predicates.split("\n"))
        combined_predicates = f"{user_preds_indented}\n    {outcome_preds}"
    else:
        combined_predicates = outcome_preds

    # 4) Types block
    types_str = " ".join(sorted(distinct_types))

    # 5) Construct final domain text (direct string approach)
    domain_text = f"""
(define (domain {domain_name})
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    {types_str}
  )

  (:predicates
    {combined_predicates}
  )

  (:functions
    ; e.g. (duration_spent)
  )

  {''.join(pddl_actions)}
)
"""
    return domain_text.strip()

###############################################################################
# 9) COMBINED: build_pddl_from_rows
###############################################################################
def load_q1_domain_names(file_name_q1):
    """
    Read Q1 CSV and return dict: pdf_filename -> domain_name (sanitized vessel name).
    If a filename appears multiple times, the first non-empty result wins.
    """
    mapping = {}
    with open(file_name_q1, "r") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            fn = (row.get('filename') or "").strip()
            res = row.get('result') or ""
            if not fn or fn in mapping:
                continue
            name = extract_between_asterisks(res)
            if not name:
                continue
            mapping[fn] = name.lower().replace(' ', '_').replace('/', '-')
    return mapping


def build_pddl_for_row(q5_row, domain_name_map, parser=parse_q5_result):
    """
    Given a Q5 row and a {filename->domain_name} map, return (pddl_text, pdf_filename)
    or (None, pdf_filename) if the row has no usable actions.
    `parser` selects the Q5 parsing strategy (Geomar-Kiel canonical vs. NOAA multi-section).
    """
    pdf_filename = (q5_row.get('filename') or "").strip()
    actions_text = q5_row.get('result') or ""
    if not pdf_filename or not actions_text.strip():
        return None, pdf_filename

    domain_name = domain_name_map.get(pdf_filename) or os.path.splitext(pdf_filename)[0]
    domain_name = domain_name.lower().replace(' ', '_').replace('/', '-')

    user_predicates = extract_between_asterisks(actions_text)
    cleaned_text = preprocess_q5_text(actions_text)
    all_actions = parser(cleaned_text)
    if not all_actions:
        return None, pdf_filename

    pddl_domain = create_pddl_domain(domain_name, user_predicates, all_actions)
    return pddl_domain, pdf_filename


###############################################################################
# 10) MAIN: generate one PDDL per Q5 row, filename derived from first column
###############################################################################
def run_dataset(dataset_dir, q1_csv, q5_csv, out_dir, parser):
    """Generate one PDDL per Q5 row in `dataset_dir` using the given parser."""
    q1_path = os.path.join(dataset_dir, q1_csv)
    q5_path = os.path.join(dataset_dir, q5_csv)

    domain_name_map = load_q1_domain_names(q1_path)

    written = 0
    skipped = 0
    stem_counts = {}
    with open(q5_path, "r") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            pddl_text, pdf_filename = build_pddl_for_row(row, domain_name_map, parser=parser)
            if pddl_text is None:
                skipped += 1
                continue

            stem = os.path.splitext(pdf_filename)[0]
            n = stem_counts.get(stem, 0)
            stem_counts[stem] = n + 1
            out_name = f"{stem}.pddl" if n == 0 else f"{stem}_{n+1}.pddl"
            out_path = os.path.join(out_dir, out_name)

            with open(out_path, "w") as f:
                f.write(pddl_text)
            written += 1
    return written, skipped


if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.abspath(__file__))
    curated_root = os.path.join(base_dir, "..", "datasets", "CuratedQAs")
    out_dir = os.path.join(base_dir, "..", "domains")
    os.makedirs(out_dir, exist_ok=True)

    datasets = [
        {
            "dir": os.path.join(curated_root, "Geomar-Kiel"),
            "q1": "GEOMAR-Kielscenario_extractionQ1.csv",
            "q5": "GEOMAR-Kielscenario_extractionQ5.csv",
            "parser": parse_q5_result,
        },
        {
            "dir": os.path.join(curated_root, "NOAA"),
            "q1": "NOAAscenario_extractionQ1.csv",
            "q5": "NOAAscenario_extractionQ5.csv",
            "parser": parse_noaa_q5_result,
        },
    ]

    total_written = 0
    for ds in datasets:
        label = os.path.basename(os.path.normpath(ds["dir"]))
        written, skipped = run_dataset(ds["dir"], ds["q1"], ds["q5"], out_dir, ds["parser"])
        total_written += written
        print(f"[{label}] wrote {written} PDDL files (skipped {skipped} empty/unparseable rows).")

    print(f"Total: {total_written} PDDL files in {os.path.abspath(out_dir)}.")
