(define (domain rv_poseidon)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_not_specified)
    (outcome_not_specified)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action inspection
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action unloading_equipment
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action software_installation
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action ballast_bottles_installation
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action vacuum_tests
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action overnight_simulation_mission_(07_march)
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action overnight_simulation_mission_(08_march)
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action mission_planning_and_review
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_not_specified)
    )
    :effect (and
      (outcome_not_specified)
    )
  )

  (:action gps_&_iridium_connection_test
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action post-mission_data_analysis
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_not_specified)
    )
    :effect (and
      (outcome_not_specified)
    )
  )

  (:action mission_(26_august)
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

)