(define (domain auv_failure)

  (:requirements :strips :typing :fluents :durative-actions)

  (:types 
    auv sensor)

  (:predicates 
    (mission_started ?auv - auv)
    (sensor_operational ?sensor - sensor)
    (mission_failed ?auv - auv)
    (auv_recovered ?auv - auv)
    (auv_ready ?auv - auv)
  )

  (:functions 
    (mission_time ?auv - auv) ; Represents the duration of the mission in minutes
  )

  (:durative-action start_mission
    :parameters (?auv - auv ?sensor - sensor)
    :duration (= ?duration 23) ; Scheduled duration for the mission
    :condition (and (at start (auv_ready ?auv)) 
                    (at start (sensor_operational ?sensor))
                    (at start (not (mission_started ?auv))))
    :effect (and (at start (mission_started ?auv))
                 (at end (not (sensor_operational ?sensor)))
                 (at end (mission_failed ?auv)))
  )

  (:durative-action recover_auv
    :parameters (?auv - auv)
    :duration (= ?duration 10) ; Arbitrary time for recovery
    :condition (and (at start (mission_failed ?auv)))
    :effect (at end (auv_recovered ?auv))
  )
)

