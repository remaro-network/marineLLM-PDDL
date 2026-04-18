(define (domain i_don't_know.)
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

  
  (:action conducting_in-situ_measurements_of_chemicals
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action surveying_marine_activities_in_massachusetts_bay
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action monitoring_environmental_parameters_in_support_of_various_activities
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

)