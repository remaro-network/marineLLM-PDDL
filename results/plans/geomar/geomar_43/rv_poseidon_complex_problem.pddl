
(define (problem rv_poseidon_complex_problem)
  (:domain rv_poseidon_complex)
  
  (:objects
    
    ixsea_octans_1000 garmin_152 ctd48m - sensor
    motion_task gps_task ctd_task analysis_task - task
    
  )
  
  (:init
    
    (not (sensor_calibrated ixsea_octans_1000))
    (not (sensor_calibrated garmin_152))
    (not (sensor_calibrated ctd48m))
    (not (motion_data_collected ixsea_octans_1000))
    (not (gps_position_acquired garmin_152))
    (not (ctd_measurement_taken ctd48m))
    (= (data_quality motion_task) 0)
    (= (data_quality gps_task) 0)
    (= (data_quality ctd_task) 0)
    (= (time_spent) 0)
    (= (energy_level) 50) ; Start with a limited amount of energy
    (energy_available)
    
  )
  
  (:goal
    
    (and
      (motion_data_collected ixsea_octans_1000)
      (gps_position_acquired garmin_152)
      (ctd_measurement_taken ctd48m)
      (data_analyzed analysis_task)
    )
    
  )
)
