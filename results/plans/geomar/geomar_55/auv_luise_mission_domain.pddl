(define (domain auv_luise_mission)

  (:requirements :strips :typing :fluents :durative-actions)

  (:types 
    auv sensor)

  (:predicates 
    (mission_started ?auv - auv)
    (mission_aborted ?auv - auv)
    (mission_completed ?auv - auv)
    (communication_lost ?auv - auv)
    (sensor_tested ?sensor - sensor)
    (vehicle_error ?auv - auv)
  )

  (:functions 
    (depth ?auv - auv) ; Represents the current depth of the AUV
    (duration ?auv - auv) ; Represents the duration of the mission in minutes
  )

  ;; Action to start the mission
  (:durative-action start_mission
    :parameters (?auv - auv)
    :duration (= ?duration 45)
    :condition (and (at start (not (mission_started ?auv)))
                    (at start (= (depth ?auv) 0)))
    :effect (and (at start (mission_started ?auv))
                 (at end (vehicle_error ?auv))
                 (at end (communication_lost ?auv))
                 (at end (mission_aborted ?auv))
                 (at end (assign (depth ?auv) 100)))
  )

  ;; Action to test sensors (would occur if the mission had not been aborted)
  (:durative-action test_sensor
    :parameters (?auv - auv ?sensor - sensor)
    :duration (= ?duration 5) ; Assuming a sensor test takes 5 minutes
    :condition (and (at start (mission_started ?auv))
                    (at start (not (vehicle_error ?auv)))
                    (at start (not (communication_lost ?auv)))
                    (at start (not (mission_aborted ?auv))))
    :effect (at end (sensor_tested ?sensor))
  )

  ;; Action to abort the mission due to vehicle error
  (:durative-action abort_mission
    :parameters (?auv - auv)
    :duration (= ?duration 10) ; Arbitrary time for aborting the mission
    :condition (at start (vehicle_error ?auv))
    :effect (at end (mission_aborted ?auv))
  )
)

