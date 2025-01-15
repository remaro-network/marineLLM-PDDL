(define (domain rv_poseidon_complex)

  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types 
    sensor task)

  (:predicates 
    (motion_data_collected ?sensor - sensor)
    (gps_position_acquired ?sensor - sensor)
    (ctd_measurement_taken ?sensor - sensor)
    (sensor_calibrated ?sensor - sensor)
    (data_analyzed ?task - task)
    (energy_available)
  )

  (:functions 
    (data_quality ?task - task) ; Represents the quality of the data collected from sensors
    (time_spent) ; Total time spent on all tasks
    (energy_level) ; Represents the energy level available for tasks
  )

  ;; Durative action to calibrate a sensor before collecting data
  (:durative-action calibrate_sensor
    :parameters (?sensor - sensor)
    :duration (= ?duration 10)
    :condition (and (at start (not (sensor_calibrated ?sensor))))
    :effect (and (at end (sensor_calibrated ?sensor))
                 (at end (increase (time_spent) 10))
                 (at end (decrease (energy_level) 5)))
  )

  ;; Durative action to collect motion data using the Motion Sensor IXSEA OCTANS 1000
  (:durative-action collect_motion_data
    :parameters (?sensor - sensor)
    :duration (= ?duration 15)
    :condition (and (at start (sensor_calibrated ?sensor))
                    (at start (not (motion_data_collected ?sensor)))
                    (at start (energy_available)))
    :effect (and (at end (motion_data_collected ?sensor))
                 (at end (increase (data_quality motion_task) 5))
                 (at end (increase (time_spent) 15))
                 (at end (decrease (energy_level) 10)))
  )

  ;; Durative action to acquire GPS position using the GPS-Receiver GARMIN 152
  (:durative-action acquire_gps_position
    :parameters (?sensor - sensor)
    :duration (= ?duration 10)
    :condition (and (at start (sensor_calibrated ?sensor))
                    (at start (not (gps_position_acquired ?sensor)))
                    (at start (energy_available)))
    :effect (and (at end (gps_position_acquired ?sensor))
                 (at end (increase (data_quality gps_task) 3))
                 (at end (increase (time_spent) 10))
                 (at end (decrease (energy_level) 7)))
  )

  ;; Durative action to take CTD measurements using the CTD48M Sound Velocity Probe
  (:durative-action take_ctd_measurement
    :parameters (?sensor - sensor)
    :duration (= ?duration 20)
    :condition (and (at start (sensor_calibrated ?sensor))
                    (at start (not (ctd_measurement_taken ?sensor)))
                    (at start (energy_available)))
    :effect (and (at end (ctd_measurement_taken ?sensor))
                 (at end (increase (data_quality ctd_task) 7))
                 (at end (increase (time_spent) 20))
                 (at end (decrease (energy_level) 15)))
  )

  ;; Durative action to analyze collected data
  (:durative-action analyze_data
    :parameters (?task - task)
    :duration (= ?duration 30)
    :condition (and (at start (motion_data_collected ixsea_octans_1000))
                    (at start (gps_position_acquired garmin_152))
                    (at start (ctd_measurement_taken ctd48m))
                    (at start (>= (data_quality motion_task) 5))
                    (at start (>= (data_quality gps_task) 3))
                    (at start (>= (data_quality ctd_task) 7)))
    :effect (and (at end (data_analyzed ?task))
                 (at end (increase (time_spent) 30))
                 (at end (decrease (energy_level) 20)))
  )
)

