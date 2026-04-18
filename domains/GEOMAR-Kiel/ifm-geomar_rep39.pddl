(define (domain rv_sonne)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action task_1
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_failure))
    )
    :effect (and
      (at end (outcome_failure))
    )
  )

  (:durative-action task_2
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