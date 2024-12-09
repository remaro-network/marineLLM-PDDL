(define (domain mission-report)
  (:requirements :strips :typing)
  
  (:types 
    task - object
    duration - number
    outcome - object
  )
  
  (:predicates
    (task-started ?t - task)
    (task-completed ?t - task)
    (task-failed ?t - task)
    (task-duration ?t - task ?d - duration)
    (task-outcome ?t - task ?o - outcome)
  )

  (:action start-seismic-profiling
    :parameters ()
    :precondition (not (task-started seismic-profiling))
    :effect (and
      (task-started seismic-profiling)
      (task-duration seismic-profiling duration-24h)
    )
  )

  (:action complete-seismic-profiling
    :parameters ()
    :precondition (task-started seismic-profiling)
    :effect (and
      (task-completed seismic-profiling)
      (task-outcome seismic-profiling outcome-successful-recovery)
    )
  )

  (:action start-heat-flow-measurements
    :parameters ()
    :precondition (not (task-started heat-flow-measurements))
    :effect (and
      (task-started heat-flow-measurements)
      (task-duration heat-flow-measurements duration-multiple)
    )
  )

  (:action complete-heat-flow-measurements
    :parameters ()
    :precondition (task-started heat-flow-measurements)
    :effect (and
      (task-completed heat-flow-measurements)
      (task-outcome heat-flow-measurements outcome-partial-completion)
    )
  )

  (:action start-magnetometer-profiles
    :parameters ()
    :precondition (not (task-started magnetometer-profiles))
    :effect (and
      (task-started magnetometer-profiles)
      (task-duration magnetometer-profiles duration-transit)
    )
  )

  (:action complete-magnetometer-profiles
    :parameters ()
    :precondition (task-started magnetometer-profiles)
    :effect (and
      (task-completed magnetometer-profiles)
      (task-outcome magnetometer-profiles outcome-successful-data-collection)
    )
  )

  (:action start-seismic-profile-P03
    :parameters ()
    :precondition (not (task-started seismic-profile-P03))
    :effect (and
      (task-started seismic-profile-P03)
      (task-duration seismic-profile-P03 duration-shortened)
    )
  )

  (:action complete-seismic-profile-P03
    :parameters ()
    :precondition (task-started seismic-profile-P03)
    :effect (and
      (task-completed seismic-profile-P03)
      (task-outcome seismic-profile-P03 outcome-partial-completion)
    )
  )
)

