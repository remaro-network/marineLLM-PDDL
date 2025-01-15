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
# 9) COMBINED: fill_domain_template_from_csv
###############################################################################
def fill_domain_template_from_csv(file_name_q1, file_name_q5):
    """
    1) Read domain_name from Q1 (column 'result').
    2) Read user predicates + raw text from Q5 (column 'result').
    3) Pre-process Q5 text to unify multiple formats (if needed).
    4) Parse the final text once to extract (action_name, action_duration, action_outcome).
    5) Build final domain, deciding durative vs non-durative if duration is unknown.
    6) Return domain text.
    """
    domain_name = ""
    user_predicates = ""
    actions_text = ""

    # --- Step 1: scenario_extraction_Q1.csv -> domain name
    with open(file_name_q1, "r") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            if row.get('result'):
                domain_name = extract_between_asterisks(row['result'])
                domain_name = domain_name.lower().replace(' ', '_').replace('/','-')
                break

    # --- Step 2: scenario_extraction_Q5.csv -> user predicates + actions text
    with open(file_name_q5, "r") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            if row.get('result'):
                # first *...* => user_predicates
                user_predicates = extract_between_asterisks(row['result'])
                # full text => actions_text
                actions_text = row['result']
                break

    # --- Step 3: Pre-process Q5 text (combine or transform multiple formats)
    cleaned_text = preprocess_q5_text(actions_text)

    # --- Step 4: Parse final text to get list of {action_name, action_duration, action_outcome}
    all_actions = parse_q5_result(cleaned_text)

    # --- Step 5: Build final domain
    pddl_domain = create_pddl_domain(domain_name, user_predicates, all_actions)

    # --- Step 6: Return or save the domain
    return pddl_domain, domain_name

###############################################################################
# 10) EXAMPLE USAGE
###############################################################################
if __name__ == "__main__":
    file_name_q1 = "/home/mahya/Desktop/marineLLM-PDDL/datasets/GEOMAR-Kiel/scenario_extractionQ1.csv"
    file_name_q5 = "/home/mahya/Desktop/marineLLM-PDDL/datasets/GEOMAR-Kiel/scenario_extractionQ5.csv"
    
    
    pddl_domain_output, domain_name = fill_domain_template_from_csv(file_name_q1, file_name_q5)
    print(pddl_domain_output)


    directory = "domains"
    if not os.path.exists(directory):
      os.makedirs(directory)

    file_path = os.path.join(directory, domain_name+".pddl")
    with open(file_path, "w") as f:
      f.write(pddl_domain_output)

   #  f = open(domain_name + ".txt", "x")

   #  with open(domain_name + ".pddl", "w") as f:   # Opens file and casts as f 
      # f.write(pddl_domain_output)
      f.close()
