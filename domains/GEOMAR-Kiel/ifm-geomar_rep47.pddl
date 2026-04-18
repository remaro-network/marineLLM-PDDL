(define (domain i_don't_know.)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    mission survey
  )

  (:predicates
    (precondition_for_failure)
    (outcome_failure)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action usbl_test_mission_anton_91_pre_mission_1
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action usbl_test_mission_anton_91_pre_mission_2
    :parameters (?m - mission)
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action long_survey_mission_anton_91
    :parameters (?s - survey ?m - mission)
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action lipari_deep_dive_anton_92
    :parameters ()
    :precondition (and
      (precondition_for_failure)
    )
    :effect (and
      (outcome_failure)
    )
  )

)