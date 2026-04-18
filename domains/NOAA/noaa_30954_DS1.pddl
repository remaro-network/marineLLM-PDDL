(define (domain noaa_30954_ds1)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    survey
  )

  (:predicates
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action underwater_visual_surveys_of_corals,_sponges,_and_seafloor_substratum_types
    :parameters (?s - survey)
    :duration (= ?duration 6.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:durative-action auv_surveys_conducted_3_m_above_the_seafloor
    :parameters (?s - survey)
    :duration (= ?duration 6.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

  (:durative-action rov_surveys_conducted_an_average_height_of_2_m_above_the_seafloor
    :parameters (?s - survey)
    :duration (= ?duration 5.0)
    :condition (and
      (at start (precondition_for_unknown))
    )
    :effect (and
      (at end (outcome_unknown))
    )
  )

)