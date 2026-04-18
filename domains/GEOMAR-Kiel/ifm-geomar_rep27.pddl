(define (domain rv_sonne)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_failure_due_to_compressor_failure)
    (outcome_failure_due_to_compressor_failure)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action seismic_measurements_until_10
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:action deployment_of_two_cat_meters
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action recovery_of_one_obmt_station
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action installation_of_cat_meters
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action third_seismic_transect_started_at_midnight_on_16th_nov.
    :parameters ()
    :precondition (and
      (precondition_for_failure_due_to_compressor_failure)
    )
    :effect (and
      (outcome_failure_due_to_compressor_failure)
    )
  )

  (:action deployment_of_rov_for_csem_measurement
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action redeployment_of_six_obs_for_long-term_observation
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action mcs_profiling_interrupted_due_to_compressor_failures
    :parameters ()
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action muc_deployment_with_limited_success
    :parameters ()
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

  (:action rov_deployment_for_csem_measurements
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action mcs_profiling
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

)