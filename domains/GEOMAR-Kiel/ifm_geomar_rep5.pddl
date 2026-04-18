(define (domain rv_sonne)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    ctd
  )

  (:predicates
    (precondition_for_2_days,_success_–_successful.)
    (outcome_2_days,_success_–_successful.)
    (precondition_for_not_specified,_success_-_successful)
    (outcome_not_specified,_success_-_successful)
    (precondition_for_not_specified,_success_–_failure.)
    (outcome_not_specified,_success_–_failure.)
    (precondition_for_not_specified,_success_–_successful.)
    (outcome_not_specified,_success_–_successful.)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action huddle_test
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_2_days,_success_–_successful.))
    )
    :effect (and
      (at end (outcome_2_days,_success_–_successful.))
    )
  )

  (:durative-action test_3_with_ctd_frame_and_surface_modem
    :parameters (?i - ctd)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_not_specified,_success_–_failure.))
    )
    :effect (and
      (at end (outcome_not_specified,_success_–_failure.))
    )
  )

  (:durative-action maintenance_of_system_components
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_not_specified,_success_–_successful.))
    )
    :effect (and
      (at end (outcome_not_specified,_success_–_successful.))
    )
  )

  (:durative-action underwater_communication_tests
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_not_specified,_success_–_failure.))
    )
    :effect (and
      (at end (outcome_not_specified,_success_–_failure.))
    )
  )

  (:durative-action recovery_and_deployment_of_ocean_bottom_recorder_instruments
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_not_specified,_success_-_successful))
    )
    :effect (and
      (at end (outcome_not_specified,_success_-_successful))
    )
  )

)