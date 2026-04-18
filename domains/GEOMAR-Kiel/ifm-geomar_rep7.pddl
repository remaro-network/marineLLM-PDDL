(define (domain l’atalante)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_mixed)
    (outcome_mixed)
    (precondition_for_successful)
    (outcome_successful)
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action arrival_of_participants
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action luggage_issue
    :parameters ()
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action inspection_of_indp,_unloading,_software_installation,_vacuum_tests,_overnight_simulation
    :parameters ()
    :precondition (and
      (precondition_for_mixed)
    )
    :effect (and
      (outcome_mixed)
    )
  )

  (:action overnight_simulation_mission
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action programming_visualization_tool,_software_updates,_gps_&_iridium_test
    :parameters ()
    :precondition (and
      (precondition_for_mixed)
    )
    :effect (and
      (outcome_mixed)
    )
  )

  (:action overnight_simulation_mission_completion
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action post-mission_data_analysis,_mission_playback,_side-scan_review
    :parameters (?m - mission)
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

  (:action mission_split_in_fix_altitude_and_depth,_recorded_good_data,_aborted_due_to_rough_sea
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_mixed)
    )
    :effect (and
      (outcome_mixed)
    )
  )

)