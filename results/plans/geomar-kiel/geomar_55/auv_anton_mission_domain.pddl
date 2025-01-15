(define (domain auv_anton_mission)

  (:requirements :strips :typing :fluents :durative-actions)

  (:types 
    auv setting)

  (:predicates 
    (mission_started ?auv - auv)
    (mission_completed ?auv - auv)
    (acoustic_command_tested ?auv - auv)
    (drift_tested ?auv - auv)
    (no_response ?auv - auv)
    (usbl_received ?auv - auv)
    (settings_changed ?auv - auv)
  )

  (:functions 
    (depth ?auv - auv) ; Represents the current depth of the AUV
    (duration ?auv - auv) ; Represents the duration of the mission in minutes
  )

  ;; Action to start a mission with an acoustic GoTo command and handle drift
  (:durative-action acoustic_goto_command
    :parameters (?auv - auv)
    :duration (= ?duration 10)
    :condition (and (at start (not (mission_started ?auv)))
                    (at start (= (depth ?auv) 200)))
    :effect (and (at start (mission_started ?auv))
                 (at end (drift_tested ?auv))
                 (at end (mission_completed ?auv)))
  )

  ;; Action to test acoustic commands
  (:durative-action test_acoustic_command
    :parameters (?auv - auv)
    :duration (= ?duration 14)
    :condition (and (at start (not (mission_started ?auv)))
                    (at start (= (depth ?auv) 20)))
    :effect (and (at start (mission_started ?auv))
                 (at end (acoustic_command_tested ?auv))
                 (at end (mission_completed ?auv)))
  )

  ;; Action for drift testing
  (:durative-action perform_drift_test
    :parameters (?auv - auv)
    :duration (= ?duration 29)
    :condition (and (at start (not (mission_started ?auv)))
                    (at start (= (depth ?auv) 50)))
    :effect (and (at start (mission_started ?auv))
                 (at end (drift_tested ?auv))
                 (at end (mission_completed ?auv)))
  )

  ;; Action to test acoustic abort command with no response, then change settings
  (:durative-action test_acoustic_abort_command
    :parameters (?auv - auv)
    :duration (= ?duration 6)
    :condition (and (at start (not (mission_started ?auv)))
                    (at start (= (depth ?auv) 20)))
    :effect (and (at start (mission_started ?auv))
                 (at end (no_response ?auv))
                 (at end (settings_changed ?auv))
                 (at end (mission_completed ?auv)))
  )

  ;; Action to test acoustic commands with new settings, resulting in no response
  (:durative-action test_acoustic_command_new_settings
    :parameters (?auv - auv)
    :duration (= ?duration 8)
    :condition (and (at start (not (mission_started ?auv)))
                    (at start (= (depth ?auv) 20))
                    (at start (settings_changed ?auv)))
    :effect (and (at start (mission_started ?auv))
                 (at end (no_response ?auv))
                 (at end (mission_completed ?auv)))
  )

  ;; Action to test acoustic commands again with new settings, resulting in no response
  (:durative-action test_acoustic_command_new_settings_again
    :parameters (?auv - auv)
    :duration (= ?duration 7)
    :condition (and (at start (not (mission_started ?auv)))
                    (at start (= (depth ?auv) 20))
                    (at start (settings_changed ?auv)))
    :effect (and (at start (mission_started ?auv))
                 (at end (no_response ?auv))
                 (at end (mission_completed ?auv)))
  )

  ;; Action for successful communication with USBL
  (:durative-action receive_usbl_signal
    :parameters (?auv - auv)
    :duration (= ?duration 4)
    :condition (and (at start (not (mission_started ?auv)))
                    (at start (= (depth ?auv) 20))
                    (at start (settings_changed ?auv)))
    :effect (and (at start (mission_started ?auv))
                 (at end (usbl_received ?auv))
                 (at end (mission_completed ?auv)))
  )
)

