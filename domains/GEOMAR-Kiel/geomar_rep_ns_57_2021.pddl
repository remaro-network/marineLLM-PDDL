(define (domain l'atalante)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    survey
  )

  (:predicates
    (precondition_for_not_applicable)
    (outcome_not_applicable)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action sound_velocity_profile_collection
    :parameters ()
    :duration (= ?duration 11.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action bathymetric_surveying
    :parameters (?s - survey)
    :duration (= ?duration 34.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action instrument_dead_time
    :parameters ()
    :duration (= ?duration 34.0)
    :condition (and
      (at start (precondition_for_not_applicable))
    )
    :effect (and
      (at end (outcome_not_applicable))
    )
  )

  (:durative-action transit_time
    :parameters ()
    :duration (= ?duration 29.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

)