(define (domain noaa_10612_ds1)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    survey
  )

  (:predicates
    (precondition_for_success)
    (outcome_success)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action conduct_a_survey_of_a_shipwreck_off_kythnos
    :parameters (?s - survey)
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:durative-action transit_to_piraeus
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:durative-action demobilize
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

  (:durative-action pack_whoi_equipment_for_shipping_to_usa
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_success))
    )
    :effect (and
      (at end (outcome_success))
    )
  )

)