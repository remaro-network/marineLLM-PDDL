(define (domain l’atalante)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    survey
  )

  (:predicates
    (precondition_for_i_don't_know)
    (outcome_i_don't_know)
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action filming
    :parameters ()
    :precondition (and
      (precondition_for_i_don't_know)
    )
    :effect (and
      (outcome_i_don't_know)
    )
  )

  (:durative-action sound_velocity_profile
    :parameters ()
    :duration (= ?duration 11.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:durative-action bathymetric_surveying
    :parameters (?s - survey)
    :duration (= ?duration 34.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:durative-action dead_time
    :parameters ()
    :duration (= ?duration 34.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:durative-action transit_time
    :parameters ()
    :duration (= ?duration 29.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

)