(define (domain rv_sonne)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission survey
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

  
  (:durative-action transit_from_emden_to_italy
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

  (:durative-action double-check_geodesy_stations_off_mt._etna
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action deploy_six_long-term_ocean_bottom_seismometers_off_mt._etna
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action map_recent_volcanic_deposits_off_stromboli
    :parameters ()
    :duration (= ?duration 0.0)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action usbl_test_mission_anton_91_(pre_mission_1)
    :parameters (?m - mission)
    :duration (= ?duration 0.1)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action usbl_test_mission_anton_91_(pre_mission_1)
    :parameters (?m - mission)
    :duration (= ?duration 0.11666666666666667)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action long_survey_mission_(anton_91)
    :parameters (?s - survey ?m - mission)
    :duration (= ?duration 0.4)
    :condition (and
      (at start (precondition_for_successful))
    )
    :effect (and
      (at end (outcome_successful))
    )
  )

  (:durative-action dive_off_lipari_(anton_92)
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