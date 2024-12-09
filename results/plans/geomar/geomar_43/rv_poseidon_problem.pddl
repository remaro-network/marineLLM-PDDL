(define (problem rv_poseidon_problem)
  (:domain rv_poseidon)
  
  (:objects
    ixsea_octans_1000 garmin_152 ctd48m - sensor
    motion_task gps_task ctd_task analysis_task - task
  )
  
  (:init
    (not (motion_data_collected ixsea_octans_1000))
    (not (gps_position_acquired garmin_152))
    (not (ctd_measurement_taken ctd48m))
    (= (data_quality motion_task) 0)
    (= (data_quality gps_task) 0)
    (= (data_quality ctd_task) 0)
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

