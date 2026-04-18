(define (domain r-v_aegaeo)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission
  )

  (:predicates
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action mission
    :parameters (?m - mission)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:durative-action mission
    :parameters (?m - mission)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:durative-action mission
    :parameters (?m - mission)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

)