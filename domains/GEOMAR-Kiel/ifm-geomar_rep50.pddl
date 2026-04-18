(define (domain ifm-geomar_rep50)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_success)
    (outcome_success)
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action bathymetric_mapping_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:durative-action high-resolution_multichannel_seismic_profiling_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:durative-action side-scan_sonar_mapping_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:durative-action coring_program_-_duration
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