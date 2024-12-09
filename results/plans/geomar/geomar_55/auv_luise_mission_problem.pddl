(define (problem auv_luise_mission_problem)
  (:domain auv_luise_mission)
  
  (:objects
    luise - auv
    ins dvl ctd pressure_sensor usbl2 gps camera - sensor
  )
  
  (:init
    (= (depth luise) 0)
    (= (duration luise) 45)
  )
  
  (:goal
    (and
      (mission_aborted luise)
      (communication_lost luise)
      (vehicle_error luise)
      ;; The goal is set assuming the mission fails, and no sensors are tested
      (not (sensor_tested ins))
      (not (sensor_tested dvl))
      (not (sensor_tested ctd))
      (not (sensor_tested pressure_sensor))
      (not (sensor_tested usbl2))
      (not (sensor_tested gps))
      (not (sensor_tested camera))
    )
  )
)

