(define (domain rv_poseidon)

  (:requirements :strips :typing :fluents :durative-actions)

  (:types 
    sensor task)

  (:predicates 
    (motion_data_collected ?sensor - sensor)
    (gps_position_acquired ?sensor - sensor)
    (ctd_measurement_taken ?sensor - sensor)
    (data_analyzed ?task - task)
  )

  (:functions 
    (data_quality ?task - task) ; Represents the quality of the data collected from sensors
  )

  ;; Durative action to collect motion data using the Motion Sensor IXSEA OCTANS 1000
  (:durative-action collect_motion_data
    :parameters (?sensor - sensor)
    :duration (= ?duration 15)
    :condition (and (at start (not (motion_data_collected ?sensor))))
    :effect (and (at end (motion_data_collected ?sensor))
                 (at end (increase (data_quality motion_task) 5)))
  )

  ;; Durative action to acquire GPS position using the GPS-Receiver GARMIN 152
  (:durative-action acquire_gps_position
    :parameters (?sensor - sensor)
    :duration (= ?duration 10)
    :condition (and (at start (not (gps_position_acquired ?sensor))))
    :effect (and (at end (gps_position_acquired ?sensor))
                 (at end (increase (data_quality gps_task) 3)))
  )

  ;; Durative action to take CTD measurements using the CTD48M Sound Velocity Probe
  (:durative-action take_ctd_measurement
    :parameters (?sensor - sensor)
    :duration (= ?duration 20)
    :condition (and (at start (not (ctd_measurement_taken ?sensor))))
    :effect (and (at end (ctd_measurement_taken ?sensor))
                 (at end (increase (data_quality ctd_task) 7)))
  )

  ;; Durative action to analyze collected data after gathering motion, GPS, and CTD data
  (:durative-action analyze_data
    :parameters (?task - task)
    :duration (= ?duration 30)
    :condition (and (at start (motion_data_collected ixsea_octans_1000))
                    (at start (gps_position_acquired garmin_152))
                    (at start (ctd_measurement_taken ctd48m)))
    :effect (at end (data_analyzed ?task))
  )
)

