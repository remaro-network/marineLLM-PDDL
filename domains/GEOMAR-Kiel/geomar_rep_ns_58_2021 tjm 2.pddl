(define (domain rv_poseidon)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission
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

  
  (:durative-action mission_047
    :parameters (?m - mission)
    :duration (= ?duration 1.2166666666666668)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action mission_048
    :parameters (?m - mission)
    :duration (= ?duration 2.033333333333333)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action mission_050
    :parameters (?m - mission)
    :duration (= ?duration 3.0)
    :condition (and
      (at start (precondition_for_failure))
    )
    :effect (and
      (at end (outcome_failure))
    )
  )

)