(define (domain rv_poseidon)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_failure_due_to_dvl_failure)
    (outcome_failure_due_to_dvl_failure)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:durative-action depart_from_emden_to_italy
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action deploy_marine_geodesy_stations_off_mt._etna
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action work_off_the_maltese_islands
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action return_to_mt._etna_to_check_geodesy_stations_and_deploy_ocean_bottom_seismometers
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action map_volcanic_deposits_off_stromboli
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action transit_from_aeolian_islands_to_southern_france
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action auv_dive_to_200m_off_vulcano_island
    :parameters ()
    :duration (= ?duration 0.4)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action first_dive_off_lipari
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_failure_due_to_dvl_failure))
    )
    :effect (and
      (at end (outcome_failure_due_to_dvl_failure))
    )
  )

)