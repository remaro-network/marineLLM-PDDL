(define (domain r-v_aegaeo)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    ctd survey
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_partial_failure)
    (outcome_partial_failure)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action survey_1
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action survey_2
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:durative-action survey_3
    :parameters (?s - survey)
    :duration (= ?duration 3.2)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action survey_4
    :parameters (?s - survey)
    :duration (= ?duration 4.1)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action survey_5
    :parameters (?s - survey)
    :duration (= ?duration 4.916666666666667)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action ctd_casts_at_n_alex_mv
    :parameters (?i - ctd)
    :duration (= ?duration 1.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action transit_to_giza_mv
    :parameters ()
    :duration (= ?duration 7.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action standby_(waiting_on_weather)
    :parameters ()
    :duration (= ?duration 13.0)
    :condition (and
      (at start (precondition_for_failure))
    )
    :effect (and
      (at end (outcome_failure))
    )
  )

  (:durative-action deployment_and_recovery_of_cat_meter#1
    :parameters ()
    :duration (= ?duration 2.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action download_of_partial_data_set_from_giza_t-obs
    :parameters ()
    :duration (= ?duration 1.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action t-obs_located_and_cables_cut
    :parameters ()
    :duration (= ?duration 2.0)
    :condition (and
      (at start (precondition_for_partial_failure))
    )
    :effect (and
      (at end (outcome_partial_failure))
    )
  )

  (:durative-action ctd_cast_at_giza_mv
    :parameters (?i - ctd)
    :duration (= ?duration 4.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action search_and_retrieval_of_data_loggers_from_giza_t-obs
    :parameters ()
    :duration (= ?duration 3.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

)