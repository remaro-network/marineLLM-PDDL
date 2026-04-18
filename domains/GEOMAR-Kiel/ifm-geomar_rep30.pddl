(define (domain l’atalante)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_successful)
    (outcome_successful)
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
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

  (:action duration
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action overnight_simulation_mission
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:durative-action duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:action software_updates_of_gliders
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action duration
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
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

  (:action duration
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action mission_050
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:durative-action duration
    :parameters ()
    :duration (= ?duration 3.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:action post-mission_data_analysis
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action duration
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action buoyancy_tests
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action duration
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action mission_aborted_due_to_pitch/roll_issue
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action duration
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action mission_aborted_due_to_battery_capacity
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action duration
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

)