(define (problem auv_anton_mission_problem)
  (:domain auv_anton_mission)
  
  (:objects
    anton88 anton88_1 anton88_2 anton88_3 anton88_4 anton88_5 anton88_6 - auv
  )
  
  (:init
    (= (depth anton88) 200)
    (= (duration anton88) 10)
    (= (depth anton88_1) 20)
    (= (duration anton88_1) 14)
    (= (depth anton88_2) 50)
    (= (duration anton88_2) 29)
    (= (depth anton88_3) 20)
    (= (duration anton88_3) 6)
    (= (depth anton88_4) 20)
    (= (duration anton88_4) 8)
    (= (depth anton88_5) 20)
    (= (duration anton88_5) 7)
    (= (depth anton88_6) 20)
    (= (duration anton88_6) 4)
  )
  
  (:goal
    (and
      (mission_completed anton88)
      (mission_completed anton88_1)
      (mission_completed anton88_2)
      (mission_completed anton88_3)
      (mission_completed anton88_4)
      (mission_completed anton88_5)
      (mission_completed anton88_6)
      (drift_tested anton88)
      (acoustic_command_tested anton88_1)
      (drift_tested anton88_2)
      (no_response anton88_3)
      (settings_changed anton88_3)
      (no_response anton88_4)
      (no_response anton88_5)
      (usbl_received anton88_6)
    )
  )
)

