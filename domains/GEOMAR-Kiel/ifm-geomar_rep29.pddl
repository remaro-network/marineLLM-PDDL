(define (domain rv_poseidon)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission
  )

  (:predicates
    (precondition_for_3_hours)
    (outcome_3_hours)
    (precondition_for_i_don't_know)
    (outcome_i_don't_know)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action mission_047_(21.08.10_12:15_-_15:13)
    :parameters (?m - mission)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_3_hours))
    )
    :effect (and
      (at end (outcome_3_hours))
    )
  )

  (:durative-action mission_048_(23.08.10_13:15_-_?)
    :parameters (?m - mission)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_i_don't_know))
    )
    :effect (and
      (at end (outcome_i_don't_know))
    )
  )

  (:durative-action mission_050_(26.08.10_11:27_-_?)
    :parameters (?m - mission)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_3_hours))
    )
    :effect (and
      (at end (outcome_3_hours))
    )
  )

)