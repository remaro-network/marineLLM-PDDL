(define (domain r-v_maria_s_merian)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_task_successful)
    (outcome_task_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action recovery_of_seismological_network_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_task_successful))
    )
    :effect (and
      (at end (outcome_task_successful))
    )
  )

  (:durative-action deployment_of_additional_instruments_along_a_150_nm_profile_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_task_successful))
    )
    :effect (and
      (at end (outcome_task_successful))
    )
  )

  (:durative-action shooting_along_the_profile_(so186-3-1)_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_task_successful))
    )
    :effect (and
      (at end (outcome_task_successful))
    )
  )

  (:durative-action recovery_of_remaining_instruments_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_task_successful))
    )
    :effect (and
      (at end (outcome_task_successful))
    )
  )

  (:durative-action recovery_of_bottom_station_and_additional_obs_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_task_successful))
    )
    :effect (and
      (at end (outcome_task_successful))
    )
  )

  (:durative-action inspection_of_the_test_buoy_of_the_gitews_system_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_task_successful))
    )
    :effect (and
      (at end (outcome_task_successful))
    )
  )

  (:durative-action transit_to_singapore_-_duration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_task_successful))
    )
    :effect (and
      (at end (outcome_task_successful))
    )
  )

)