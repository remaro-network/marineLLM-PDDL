(define (domain noaa_33880_ds1)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    ctd
  )

  (:predicates
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action at_sea_deliverables_(daily_plans,_sitreps,_data_files):_duration_not_specified,_success_not_mentioned
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action post_expedition_deliverables_(refined_sops,_assessments):_duration_not_specified,_success_not_mentioned
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action science_deliverables_(multibeam,_xbt,_ctd,_rov_data):_duration_not_specified,_success_not_mentioned
    :parameters (?i - ctd)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

)