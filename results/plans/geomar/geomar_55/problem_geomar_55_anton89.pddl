(define (problem auv_failure_problem)
  (:domain auv_failure)
  
  (:objects
    anton89 - auv
    pressure_sensor - sensor
  )
  
  (:init
    (auv_ready anton89)
    (sensor_operational pressure_sensor)
    (= (mission_time anton89) 23)
  )
  
  (:goal
    (and
      (mission_failed anton89)
      (auv_recovered anton89)
    )
  )
)

