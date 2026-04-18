(define (domain r-v_aegaeo)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    survey
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_success)
    (outcome_success)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action survey_1
    :parameters (?s - survey)
    :duration (= ?duration 3.8166666666666664)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:durative-action survey_2
    :parameters (?s - survey)
    :duration (= ?duration 4.683333333333334)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:durative-action survey_3
    :parameters (?s - survey)
    :duration (= ?duration 3.183333333333333)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:durative-action survey_4
    :parameters (?s - survey)
    :duration (= ?duration 4.1)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:durative-action survey_5
    :parameters (?s - survey)
    :duration (= ?duration 4.916666666666667)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:action bathymetric_data_acquisition
    :parameters ()
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

)