from string import Template

# Function to generate the domain file from a template
def generate_domain_file(domain_name, types, predicates, functions, actions, output_file):
    domain_template = """
(define (domain {domain_name})

  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types 
    {types}
  )

  (:predicates 
    {predicates}
  )

  (:functions 
    {functions}
  )

  {actions}
)
"""
    # Replace placeholders with actual values
    domain_content = domain_template.format(
        domain_name=domain_name,
        types=types,
        predicates='\n    '.join(predicates),  # Join predicates with newline and indent
        functions='\n    '.join(functions),    # Join functions with newline and indent
        actions='\n\n'.join(actions)           # Join actions with two newlines between them
    )

    # Write the domain content to the output file
    with open(output_file, 'w') as file:
        file.write(domain_content)
    print(f"Domain file '{output_file}' generated successfully.")

# Function to generate the problem file from a template
def generate_problem_file(problem_name, domain_name, objects, init_state, goal_state, output_file):
    problem_template = """
(define (problem {problem_name})
  (:domain {domain_name})
  
  (:objects
    {objects}
  )
  
  (:init
    {init_state}
  )
  
  (:goal
    {goal_state}
  )
)
"""
    # Replace placeholders with actual values
    problem_content = problem_template.format(
        problem_name=problem_name,
        domain_name=domain_name,
        objects=objects,
        init_state=init_state,
        goal_state=goal_state
    )

    # Write the problem content to the output file
    with open(output_file, 'w') as file:
        file.write(problem_content)
    print(f"Problem file '{output_file}' generated successfully.")

# Function to define predicates dynamically
def define_predicates(predicate_definitions):
    predicates = []
    for predicate in predicate_definitions:
        predicate_template = "({name} {parameters})"
        predicates.append(predicate_template.format(
            name=predicate['name'],
            parameters=' '.join(f"?{param} - {ptype}" for param, ptype in predicate['parameters'])
        ))
    return predicates

# Function to define functions dynamically
def define_functions(function_definitions):
    functions = []
    for function in function_definitions:
        function_template = "({name} {parameters})"
        functions.append(function_template.format(
            name=function['name'],
            parameters=' '.join(f"?{param} - {ptype}" for param, ptype in function['parameters'])
        ))
    return functions

# Function to define actions dynamically
def define_actions(action_definitions):
    actions = []
    for action in action_definitions:
        action_template = Template("""
  (:durative-action $action_name
    :parameters ($parameters)
    :duration (= ?duration $duration)
    :condition (and $conditions)
    :effect (and $effects)
  )
""")
        # Substitute the placeholders with action-specific values
        actions.append(action_template.substitute(
            action_name=action['name'],
            parameters=action['parameters'],
            duration=action['duration'],
            conditions='\n                    '.join(action['conditions']),
            effects='\n                 '.join(action['effects'])
        ))
    return actions

# Function to validate if goals are achievable given the initial state and actions
def validate_problem(init_state, action_definitions, goal_state):
    # Check if each goal predicate is achievable from the initial state using the defined actions
    achievable = True
    print("Validating problem setup...")
    
    # Extract the predicates in the initial state
    initial_predicates = set([line.strip() for line in init_state.splitlines() if line.strip() and not line.startswith('=')])
    print(f"Initial predicates: {initial_predicates}")

    # Extract the goals
    goals = set([line.strip() for line in goal_state.replace('(and', '').replace(')', '').splitlines() if line.strip()])
    print(f"Goals: {goals}")

    # Check if each goal can be achieved
    for goal in goals:
        if goal not in initial_predicates:
            can_achieve = False
            # Check if any action can achieve this goal
            for action in action_definitions:
                for effect in action['effects']:
                    if goal in effect:
                        can_achieve = True
                        break
                if can_achieve:
                    break
            if not can_achieve:
                print(f"Unachievable goal detected: {goal}")
                achievable = False
                break

    if achievable:
        print("All goals are potentially achievable based on the defined actions.")
    else:
        print("Some goals are not achievable. Please check the initial state and action effects.")

    return achievable

# Function to instantiate the domain and problem for any example
def instantiate_example():
    # Example Details (these can be customized for different scenarios)
    domain_name = "rv_poseidon_complex"
    types = "sensor task"
    
    # Define predicates dynamically
    predicate_definitions = [
        {'name': 'motion_data_collected', 'parameters': [('sensor', 'sensor')]},
        {'name': 'gps_position_acquired', 'parameters': [('sensor', 'sensor')]},
        {'name': 'ctd_measurement_taken', 'parameters': [('sensor', 'sensor')]},
        {'name': 'sensor_calibrated', 'parameters': [('sensor', 'sensor')]},
        {'name': 'data_analyzed', 'parameters': [('task', 'task')]},
        {'name': 'energy_available', 'parameters': []}
    ]
    predicates = define_predicates(predicate_definitions)

    # Define functions dynamically
    function_definitions = [
        {'name': 'data_quality', 'parameters': [('task', 'task')]},
        {'name': 'time_spent', 'parameters': []},
        {'name': 'energy_level', 'parameters': []}
    ]
    functions = define_functions(function_definitions)
    
    # Define actions dynamically
    action_definitions = [
        {
            'name': 'calibrate_sensor',
            'parameters': '?sensor - sensor',
            'duration': '10',
            'conditions': ['(at start (not (sensor_calibrated ?sensor)))'],
            'effects': [
                '(at end (sensor_calibrated ?sensor))',
                '(at end (increase (time_spent) 10))',
                '(at end (decrease (energy_level) 5))'
            ]
        },
        {
            'name': 'collect_motion_data',
            'parameters': '?sensor - sensor',
            'duration': '15',
            'conditions': [
                '(at start (sensor_calibrated ?sensor))',
                '(at start (not (motion_data_collected ?sensor)))',
                '(at start (energy_available))'
            ],
            'effects': [
                '(at end (motion_data_collected ?sensor))',
                '(at end (increase (data_quality motion_task) 5))',
                '(at end (increase (time_spent) 15))',
                '(at end (decrease (energy_level) 10))'
            ]
        },
        {
            'name': 'analyze_data',
            'parameters': '?task - task',
            'duration': '30',
            'conditions': [
                '(at start (motion_data_collected ixsea_octans_1000))',
                '(at start (gps_position_acquired garmin_152))',
                '(at start (ctd_measurement_taken ctd48m))',
                '(at start (>= (data_quality motion_task) 5))',
                '(at start (>= (data_quality gps_task) 3))',
                '(at start (>= (data_quality ctd_task) 7))'
            ],
            'effects': [
                '(at end (data_analyzed ?task))',
                '(at end (increase (time_spent) 30))',
                '(at end (decrease (energy_level) 20))'
            ]
        }
    ]
    actions = define_actions(action_definitions)
    
    # Problem Details (can be customized)
    problem_name = "rv_poseidon_complex_problem"
    objects = """
    ixsea_octans_1000 garmin_152 ctd48m - sensor
    motion_task gps_task ctd_task analysis_task - task
    """
    init_state = """
    (not (sensor_calibrated ixsea_octans_1000))
    (not (sensor_calibrated garmin_152))
    (not (sensor_calibrated ctd48m))
    (not (motion_data_collected ixsea_octans_1000))
    (not (gps_position_acquired garmin_152))
    (not (ctd_measurement_taken ctd48m))
    (= (data_quality motion_task) 0)
    (= (data_quality gps_task) 0)
    (= (data_quality ctd_task) 0)
    (= (time_spent) 0)
    (= (energy_level) 50) ; Start with a limited amount of energy
    (energy_available)
    """
    goal_state = """
    (and
      (motion_data_collected ixsea_octans_1000)
      (gps_position_acquired garmin_152)
      (ctd_measurement_taken ctd48m)
      (data_analyzed analysis_task)
    )
    """

    # Generate files using templates
    validate_problem(init_state, action_definitions, goal_state)
    generate_domain_file(domain_name, types, predicates, functions, actions, "rv_poseidon_complex_domain.pddl")
    generate_problem_file(problem_name, domain_name, objects, init_state, goal_state, "rv_poseidon_complex_problem.pddl")

# Main function to run the generator
if __name__ == "__main__":
    instantiate_example()
