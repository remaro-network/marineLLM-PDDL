(define (domain noaa_50339_ds1)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    ctd survey
  )

  (:predicates
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action rov_dives:_33_dives_were_conducted_on_leg_1.
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action biological_sample_collection_with_the_rov:_454_samples_were_collected.
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action ctd_casts:_79_casts_were_made,_with_various_purposes_detailed_(sound_velocity,_total_water_column_oceanography,_edna,_nutrients,_and_pom).
    :parameters (?i - ctd)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action mapping_with_em2040:_12_km^2_were_mapped.
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action mapping_with_auv_sas:_354_linear_km_were_mapped.
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action survey_with_the_ek80:_41_linear_km_were_surveyed.
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action deployment_of_2_short-term_landers.
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

)