(define (domain noaa_64474_ds1)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_anomalies_located_southwest_of_the_coal_point_area_were_observed,_but_gulped_samples_were_not_collected_at_that_location)
    (outcome_anomalies_located_southwest_of_the_coal_point_area_were_observed,_but_gulped_samples_were_not_collected_at_that_location)
    (precondition_for_not_specified_in_the_provided_context)
    (outcome_not_specified_in_the_provided_context)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action point_and_gulp_behavior_for_oil_location_and_concentration
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_not_specified_in_the_provided_context))
    )
    :effect (and
      (at end (outcome_not_specified_in_the_provided_context))
    )
  )

  (:durative-action testing_of_a_small,_light-weight_tethered_mini_depth_rov
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_anomalies_located_southwest_of_the_coal_point_area_were_observed,_but_gulped_samples_were_not_collected_at_that_location))
    )
    :effect (and
      (at end (outcome_anomalies_located_southwest_of_the_coal_point_area_were_observed,_but_gulped_samples_were_not_collected_at_that_location))
    )
  )

  (:durative-action oil_detection_in_shallow_waters_using_high_fdom_and_obs
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_not_specified_in_the_provided_context))
    )
    :effect (and
      (at end (outcome_not_specified_in_the_provided_context))
    )
  )

)