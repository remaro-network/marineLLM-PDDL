(define (domain r-v_aegaeo)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission
  )

  (:predicates
    (precondition_for_duration)
    (outcome_duration)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action dive_16_ascent
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_duration))
    )
    :effect (and
      (at end (outcome_duration))
    )
  )

  (:durative-action mission_050
    :parameters (?m - mission)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_duration))
    )
    :effect (and
      (at end (outcome_duration))
    )
  )

  (:durative-action mission_047
    :parameters (?m - mission)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_duration))
    )
    :effect (and
      (at end (outcome_duration))
    )
  )

  (:durative-action mission_048
    :parameters (?m - mission)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_duration))
    )
    :effect (and
      (at end (outcome_duration))
    )
  )

)