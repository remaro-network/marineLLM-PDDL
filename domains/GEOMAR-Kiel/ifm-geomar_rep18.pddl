(define (domain l’atalante)
  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types
    ctd survey
  )

  (:predicates
    (precondition_for_i_don't_know)
    (outcome_i_don't_know)
    (precondition_for_successful)
    (outcome_successful)
  )

  (:functions
    ; e.g. (duration_spent)
  )

  
  (:action filming_activities
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action sound_velocity_profile_collection
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action bathymetric_surveying
    :parameters (?s - survey)
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action transit_time
    :parameters ()
    :precondition (and
      (precondition_for_successful)
    )
    :effect (and
      (outcome_successful)
    )
  )

  (:action deployment_and_recovery_of_moorings
    :parameters ()
    :precondition (and
      (precondition_for_i_don't_know)
    )
    :effect (and
      (outcome_i_don't_know)
    )
  )

  (:action lowering_and_retrieval_of_the_ctd_rosette
    :parameters (?i - ctd)
    :precondition (and
      (precondition_for_i_don't_know)
    )
    :effect (and
      (outcome_i_don't_know)
    )
  )

  (:action microstructure_measurements
    :parameters ()
    :precondition (and
      (precondition_for_i_don't_know)
    )
    :effect (and
      (outcome_i_don't_know)
    )
  )

  (:action tracking_of_drifting_mooring_elements
    :parameters ()
    :precondition (and
      (precondition_for_i_don't_know)
    )
    :effect (and
      (outcome_i_don't_know)
    )
  )

  (:action submerging_of_a_glider
    :parameters ()
    :precondition (and
      (precondition_for_i_don't_know)
    )
    :effect (and
      (outcome_i_don't_know)
    )
  )

)