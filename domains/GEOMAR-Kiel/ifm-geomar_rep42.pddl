(define (domain r-v_aegaeo)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    ctd
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

  
  (:durative-action ctd_casts_(22.06.2010,_00:00_-_01:00)
    :parameters (?i - ctd)
    :duration (= ?duration 1.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action transit_to_giza_mv_(22.06.2010,_01:00_-_08:00)
    :parameters ()
    :duration (= ?duration 7.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action standby_due_to_weather_(22.06.2010,_08:00_-_21:00)
    :parameters ()
    :duration (= ?duration 13.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action rov_deployment_and_cat_meter_recovery_(22.06.2010,_21:00_-_23:00)
    :parameters ()
    :duration (= ?duration 2.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action data_download_from_giza_t-obs_(22.06.2010,_23:00_-_00:00)
    :parameters ()
    :duration (= ?duration 1.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action t-obs_operation,_cables_cut,_modem_and_data_logger_released_(23.06.2010,_01:00_-_03:00)
    :parameters ()
    :duration (= ?duration 2.0)
    :condition (and
      (at start (precondition_for_failure))
    )
    :effect (and
      (at end (outcome_failure))
    )
  )

  (:durative-action ctd_casts_(23.06.2010,_04:00_-_08:00)
    :parameters (?i - ctd)
    :duration (= ?duration 4.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action search_and_retrieval_of_data_loggers_(23.06.2010,_09:00_-_12:00)
    :parameters ()
    :duration (= ?duration 3.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action end_of_operations_(23.06.2010,_12:45)
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