(define (domain auv_mission)

  (:requirements :strips :typing :fluents :durative-actions)

  (:types 
    auv command setting)

  (:predicates 
    (drift_detected ?auv - auv)
    (command_tested ?auv - auv ?command - command)
    (command_successful ?auv - auv ?command - command)
    (settings_applied ?auv - auv ?setting - setting)
    (usb_received ?auv - auv)
    (mission_aborted ?auv - auv)
    (auv_ready ?auv - auv)
  )

  (:functions 
    (depth ?auv - auv) ; Represents the current depth of the AUV
    (duration ?auv - auv) ; Represents the duration of the current action
  )

  (:durative-action test_acoustic_goto_command
    :parameters (?auv - auv ?command - command)
    :duration (= ?duration 10)
    :condition (and (at start (auv_ready ?auv)) (at start (not (command_tested ?auv ?command))))
    :effect (and (at end (command_tested ?auv ?command))
                 (at end (drift_detected ?auv))
                 (at end (mission_aborted ?auv))
                 (at end (assign (depth ?auv) 200)))
  )

  (:durative-action test_acoustic_command
    :parameters (?auv - auv ?command - command)
    :duration (= ?duration 14)
    :condition (and (at start (auv_ready ?auv)) (at start (not (command_tested ?auv ?command))))
    :effect (and (at end (command_tested ?auv ?command))
                 (at end (command_successful ?auv ?command))
                 (at end (assign (depth ?auv) 20)))
  )

  (:durative-action drift_test
    :parameters (?auv - auv)
    :duration (= ?duration 29)
    :condition (and (at start (auv_ready ?auv)) (at start (>= (depth ?auv) 200)))
    :effect (and (at end (drift_detected ?auv))
                 (at end (assign (depth ?auv) 50)))
  )

  (:durative-action test_acoustic_abort_command
    :parameters (?auv - auv ?command - command)
    :duration (= ?duration 6)
    :condition (and (at start (auv_ready ?auv)) (at start (not (command_tested ?auv ?command))))
    :effect (and (at end (command_tested ?auv ?command))
                 (at end (command_successful ?auv ?command))
                 (at end (assign (depth ?auv) 20)))
  )

  (:durative-action apply_new_settings
    :parameters (?auv - auv ?setting - setting)
    :duration (= ?duration 8)
    :condition (at start (not (settings_applied ?auv ?setting)))
    :effect (at end (settings_applied ?auv ?setting))
  )

  (:durative-action test_acoustic_command_with_new_settings
    :parameters (?auv - auv ?command - command ?setting - setting)
    :duration (= ?duration 7)
    :condition (and (at start (auv_ready ?auv)) 
                    (at start (settings_applied ?auv ?setting)) 
                    (at start (not (command_successful ?auv ?command))))
    :effect (and (at end (command_tested ?auv ?command))
                 (at end (command_successful ?auv ?command))
                 (at end (assign (depth ?auv) 20)))
  )

  (:durative-action receive_usb_signal
    :parameters (?auv - auv)
    :duration (= ?duration 4)
    :condition (and (at start (auv_ready ?auv)) (at start (not (usb_received ?auv))))
    :effect (and (at end (usb_received ?auv))
                 (at end (assign (depth ?auv) 20)))
  )
)

