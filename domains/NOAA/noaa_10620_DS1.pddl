(define (domain noaa_10620_ds1)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action acquisition_of_data_sets:_throughout_the_expedition
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action archiving_data_sets:_within_two_years_following_the_completion_of_the_expedition
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action providing_metadata:_varies_depending_on_the_type_of_data
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action using_cims_tool:_daily_for_documenting_data_collection_activities
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action utilizing_mermaid_tool:_during_the_data_management_process
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action using_digital_atlas:_throughout_the_expedition
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action generating_daily_situation_reports:_usually_daily_during_the_expedition
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

)