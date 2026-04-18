(define (domain rv_sonne)
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

  
  (:durative-action deployment_of_ctd_duration
    :parameters (?i - ctd)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:durative-action sampling_of_volcanic_structures_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:durative-action mapping_and_sampling_of_seamounts_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:durative-action tv_grab_and_multi_corer_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

)