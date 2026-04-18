(define (domain ifm-geomar_rep51)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_task:_successful)
    (outcome_task:_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action geophysical_measurements_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_task:_successful))
    )
    :effect (and
      (at end (outcome_task:_successful))
    )
  )

  (:durative-action satellite_lander_deployments_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_task:_successful))
    )
    :effect (and
      (at end (outcome_task:_successful))
    )
  )

)