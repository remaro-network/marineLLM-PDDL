(define (domain rv_atalante,_rv_poseidon,_rv_sonne,_rv_celtic_explorer,_rv_pelagia)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    
  )

  (:predicates
    (precondition_for_cancelled)
    (outcome_cancelled)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action recovery_operations
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action bathymetric_data_acquisition
    :parameters ()
    :precondition (and
      (precondition_for_cancelled)
    )
    :effect (and
      (outcome_cancelled)
    )
  )

)