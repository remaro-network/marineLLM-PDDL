(define (domain noaa_50752_ds1)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    survey
  )

  (:predicates
    (precondition_for_duration:_0.5_and_3_hours)
    (outcome_duration:_0.5_and_3_hours)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action conducting_gridded_surveys_of_areas_known_to_host_underwater_oil_seeps_using_a_remus_600_auv_with_in_situ_sensing_and_midwater_oil_sampler_payloads
    :parameters (?s - survey)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_duration:_0.5_and_3_hours))
    )
    :effect (and
      (at end (outcome_duration:_0.5_and_3_hours))
    )
  )

)