(define (problem auv_mission_problem)
  (:domain auv_mission)
  
  (:objects
    anton88 - auv
    goto_command abort_command test_command - command
    new_settings - setting
  )
  
  (:init
    (auv_ready anton88)
    (= (depth anton88) 0)
  )
  
  (:goal
    (and
      (command_tested anton88 goto_command)
      (command_tested anton88 test_command)
      (drift_detected anton88)
      (mission_aborted anton88)
      (command_tested anton88 abort_command)
      (settings_applied anton88 new_settings)
      (command_successful anton88 test_command)
      (usb_received anton88)
    )
  )
)

