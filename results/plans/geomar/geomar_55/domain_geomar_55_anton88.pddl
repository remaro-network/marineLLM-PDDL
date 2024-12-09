(define (domain auv_mission)

  (:requirements :strips :typing :fluents)

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
    (depth ?auv - auv) ; Numeric fluent for depth
  )

  (:action test_acoustic_goto_command
    :parameters (?auv - auv ?command - command)
    :precondition (and (auv_ready ?auv) (not (command_tested ?auv ?command)))
    :effect (and (command_tested ?auv ?command) (drift_detected ?auv) (mission_aborted ?auv))
  )

  (:action test_acoustic_command
    :parameters (?auv - auv ?command - command)
    :precondition (and (auv_ready ?auv) (not (command_tested ?auv ?command)))
    :effect (and (command_tested ?auv ?command) (command_successful ?auv ?command))
  )

  (:action drift_test
    :parameters (?auv - auv)
    :precondition (and (auv_ready ?auv) (>= (depth ?auv) 200))
    :effect (drift_detected ?auv)
  )

  (:action test_acoustic_abort_command
    :parameters (?auv - auv ?command - command)
    :precondition (and (auv_ready ?auv) (not (command_tested ?auv ?command)))
    :effect (and (command_tested ?auv ?command) (command_successful ?auv ?command))
  )

  (:action apply_new_settings
    :parameters (?auv - auv ?setting - setting)
    :precondition (not (settings_applied ?auv ?setting))
    :effect (settings_applied ?auv ?setting)
  )

  (:action test_acoustic_command_with_new_settings
    :parameters (?auv - auv ?command - command ?setting - setting)
    :precondition (and (auv_ready ?auv) (settings_applied ?auv ?setting) (not (command_successful ?auv ?command)))
    :effect (and (command_tested ?auv ?command) (command_successful ?auv ?command))
  )

  (:action receive_usb_signal
    :parameters (?auv - auv)
    :precondition (and (auv_ready ?auv) (not (usb_received ?auv)))
    :effect (usb_received ?auv)
  )
)

