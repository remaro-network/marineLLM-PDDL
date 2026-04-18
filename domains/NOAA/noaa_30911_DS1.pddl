(define (domain noaa_30911_ds1)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    ctd
  )

  (:predicates
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action short_transit_east_of_cape_canaveral
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action focused_overnight_ocean_mapping_operations
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action deploying_small_boats_and_auvs_for_acoustic_calibration_in_shallow_water
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action transit_to_the_central_blake_plateau_for_usbl_calibration
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action daytime_auv_deployments_and_ctd_casts
    :parameters (?i - ctd)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action overnight_operations_focusing_on_mapping_priority_areas
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action short_transit_east_of_cape_canaveral:_not_specified
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action focused_overnight_ocean_mapping_operations:_not_specified
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action deploying_small_boats_and_auvs_for_acoustic_calibration_in_shallow_water:_first_2-3_days
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action transit_to_the_central_blake_plateau_for_usbl_calibration:_not_specified
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action daytime_auv_deployments_and_ctd_casts:_remaining_days_at_sea
    :parameters (?i - ctd)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action overnight_operations_focusing_on_mapping_priority_areas:_remaining_days_at_sea
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

)