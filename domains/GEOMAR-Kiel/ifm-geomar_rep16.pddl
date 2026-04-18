(define (domain rv_poseidon)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_successful)
    (outcome_successful)
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action duration
    :parameters ()
    :duration (= ?duration 0.1)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:action outcome
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:durative-action duration
    :parameters ()
    :duration (= ?duration 0.11666666666666667)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:action outcome
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:durative-action duration
    :parameters ()
    :duration (= ?duration 0.4)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:action outcome
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:durative-action duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:action outcome
    :parameters ()
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:durative-action duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:action outcome
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

)