(define (domain auv_camera_mission)

  (:requirements :strips :typing :fluents :durative-actions)

  (:types 
    auv setting)

  (:predicates 
    (mission_started ?auv - auv)
    (mission_completed ?auv - auv)
    (camera_fixed ?auv - auv)
    (camera_automatic ?auv - auv)
    (image_captured ?auv - auv)
  )

  (:functions 
    (depth ?auv - auv) ; Represents the current depth of the AUV
    (duration ?auv - auv) ; Represents the duration of the mission in minutes
  )

  (:durative-action start_fixed_camera_mission
    :parameters (?auv - auv)
    :duration (= ?duration 55)
    :condition (and (at start (not (mission_started ?auv)))
                    (at start (camera_fixed ?auv))
                    (at start (= (depth ?auv) 40)))
    :effect (and (at start (mission_started ?auv))
                 (at end (mission_completed ?auv))
                 (at end (image_captured ?auv)))
  )

  (:durative-action start_automatic_camera_mission
    :parameters (?auv - auv)
    :duration (= ?duration 30)
    :condition (and (at start (not (mission_started ?auv)))
                    (at start (camera_automatic ?auv))
                    (at start (= (depth ?auv) 40)))
    :effect (and (at start (mission_started ?auv))
                 (at end (mission_completed ?auv))
                 (at end (image_captured ?auv)))
  )

  (:durative-action continue_fixed_camera_mission
    :parameters (?auv - auv)
    :duration (= ?duration 33)
    :condition (and (at start (not (mission_completed ?auv)))
                    (at start (mission_started ?auv))
                    (at start (camera_fixed ?auv))
                    (at start (= (depth ?auv) 40)))
    :effect (and (at end (mission_completed ?auv))
                 (at end (image_captured ?auv)))
  )
)

