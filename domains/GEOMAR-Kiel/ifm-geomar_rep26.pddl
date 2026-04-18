(define (domain r-v_aegaeo)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action 25.08.10,_10
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action 26.08.10,_11
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_failure))
    )
    :effect (and
      (at end (outcome_failure))
    )
  )

  (:durative-action 20.08.10,_11
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action 21.08.10,_12
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action 21.08.10,_15
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action 23.08.10,_13
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

)