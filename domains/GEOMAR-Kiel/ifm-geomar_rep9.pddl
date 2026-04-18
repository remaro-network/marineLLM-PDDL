(define (domain r-v_aegaeo)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_success)
    (outcome_success)
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
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

  (:action mission_playback
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action side-scan_review
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action navigation_charts_and_mission_planning
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action communication_setup
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action ascent_of_dive_16
    :parameters ()
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action bathymetric_data_acquisition
    :parameters ()
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action station_325_completion
    :parameters ()
    :precondition (and
      (precondition_for_success)
    )
    :effect (and
      (outcome_success)
    )
  )

  (:action transit_to_auckland
    :parameters ()
    :precondition (and
      (precondition_for_success)
    )
    :effect (and
      (outcome_success)
    )
  )

  (:action unloading_equipment_in_auckland
    :parameters ()
    :precondition (and
      (precondition_for_success)
    )
    :effect (and
      (outcome_success)
    )
  )

  (:action disembarkment_of_scientists_and_discharge_of_airfreight
    :parameters ()
    :precondition (and
      (precondition_for_success)
    )
    :effect (and
      (outcome_success)
    )
  )

  (:action chief_scientist's_presentation
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

)