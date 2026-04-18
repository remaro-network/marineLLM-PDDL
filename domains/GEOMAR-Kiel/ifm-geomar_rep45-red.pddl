(define (domain rvposeidon)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_success)
    (outcome_success)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action deployment_of_obs_and_obm
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

)