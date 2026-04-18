(define (domain rv_poseidon)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission
  )

  (:predicates
    (precondition_for_not_specified)
    (outcome_not_specified)
    (precondition_for_not_yet_conducted)
    (outcome_not_yet_conducted)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
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

  (:action gps_&_iridium_connection_test
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action buoyancy_tests
    :parameters ()
    :precondition (and
      (precondition_for_not_yet_conducted)
    )
    :effect (and
      (outcome_not_yet_conducted)
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

  (:action mission_playback
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_not_specified)
    )
    :effect (and
      (outcome_not_specified)
    )
  )

  (:action side-scan_review
    :parameters ()
    :precondition (and
      (precondition_for_not_specified)
    )
    :effect (and
      (outcome_not_specified)
    )
  )

)