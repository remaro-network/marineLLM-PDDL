(define (domain NAMV_operations)
  (:requirements :strips :durative-actions)
  
  ;; Types of tasks
  (:types task observatory instrument ship CTD OBS)

  ;; Predicates
  (:predicates
    (data_downloaded ?obs)
    (CTD_performed ?ctd)
    (microstructure_tested ?instrument)
    (methane_plume_identified ?method)
    (OBS_recovered ?obs)
    (equipment_tested ?instrument)
    (temperature_observatory_recovered ?obs)
    (task_completed ?task)
    (task_failed ?task))

  ;; Action for downloading data
  (:durative-action download_data
    :parameters (?obs - observatory)
    :duration (= ?duration 2)
    :condition (and (at start (not (data_downloaded ?obs))))
    :effect (and (at end (data_downloaded ?obs) (task_completed download_data)))
  )

  ;; Action for performing CTD cast
  (:durative-action perform_CTD_cast
    :parameters (?ctd - CTD)
    :duration (= ?duration 2)
    :condition (and (at start (not (CTD_performed ?ctd))))
    :effect (and (at end (CTD_performed ?ctd) (task_completed perform_CTD_cast)))
  )

  ;; Action for testing temperature microstructure
  (:durative-action test_microstructure
    :parameters (?instrument - instrument)
    :duration (= ?duration 1)
    :condition (and (at start (not (microstructure_tested ?instrument))))
    :effect (at end (task_failed test_microstructure))
  )

  ;; Action for identifying methane plume
  (:durative-action identify_methane_plume
    :parameters (?method - ship)
    :duration (= ?duration 4)
    :condition (and (at start (not (methane_plume_identified ?method))))
    :effect (and (at end (methane_plume_identified ?method) (task_completed identify_methane_plume)))
  )

  ;; Action for recovering OBS stations
  (:durative-action recover_OBS
    :parameters (?obs - OBS)
    :duration (= ?duration 4)
    :condition (and (at start (not (OBS_recovered ?obs))))
    :effect (and (at end (OBS_recovered ?obs) (task_completed recover_OBS)))
  )

  ;; Action for ROV deployment and equipment test
  (:durative-action deploy_ROV
    :parameters (?instrument - instrument)
    :duration (= ?duration 3.5)
    :condition (and (at start (not (equipment_tested ?instrument))))
    :effect (and (at end (equipment_tested ?instrument) (task_completed deploy_ROV)))
  )

  ;; Action for recovering temperature observatory
  (:durative-action recover_temperature_observatory
    :parameters (?obs - observatory)
    :duration (= ?duration 8)
    :condition (and (at start (not (temperature_observatory_recovered ?obs))))
    :effect (and (at end (temperature_observatory_recovered ?obs) (task_completed recover_temperature_observatory)))
  )
)
