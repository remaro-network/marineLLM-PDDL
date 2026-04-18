(define (domain noaa_29521_ds1)
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

  
  (:action rov_survey:_conducted_from_july_18_to_august_1,_2019
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action acoustic_operations:_not_specified_in_the_provided_context
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action rov_survey:_no_information_provided_on_the_success_or_failure
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

  (:action acoustic_operations:_no_information_provided_on_the_success_or_failure
    :parameters ()
    :precondition (and
      (precondition_for_unknown)
    )
    :effect (and
      (outcome_unknown)
    )
  )

)