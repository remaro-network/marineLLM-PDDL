(define (domain noaa_21362_ds1)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission survey
  )

  (:predicates
    (precondition_for_unknown)
    (outcome_unknown)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action continue_survey_of_mtmnm_4
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action continue_survey_of_mtmnm_5
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action continue_survey_of_mtmnm_6
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action continue_survey_of_mtmnm_7
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action continue_survey_of_mtmnm_8
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action continue_survey_of_mtmnm_9
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action complete_survey_operations_within_mtmnm,_commence_exploration_transit_to_guam
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action continue_exploration_transit_to_guam
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action mapping_secured;_arrive_guam,_u.s._navy_base
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action in_port,_guam
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action ex-16-05_leg_2_mission_personnel_depart_ship
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

)