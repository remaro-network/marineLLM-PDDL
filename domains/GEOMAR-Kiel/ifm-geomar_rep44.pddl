(define (domain rv_poseidon)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_i_don't_know)
    (outcome_i_don't_know)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action arrival_at_sao_vicente_(march_5)
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action inspection_of_indp_and_unloading_of_equipment_(march_6)
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action software_installation_on_gliders_(march_6)
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action vacuum_tests_on_gliders_(march_6)
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action overnight_simulation_mission_for_one_glider_(march_6-7)
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action two_gliders_sent_on_overnight_simulation_mission_(march_7-8)
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action gps_&_iridium_connection_test_(march_7)
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action post-mission_data_analysis,_mission_play-back,_and_side-scan_review
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_i_don't_know)
    )
    :effect (and
      (outcome_i_don't_know)
    )
  )

  (:action mission_with_vehicle_navigation_and_transponder_fixes_(august_25)
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action mission_with_various_instruments_(august_26)
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

)