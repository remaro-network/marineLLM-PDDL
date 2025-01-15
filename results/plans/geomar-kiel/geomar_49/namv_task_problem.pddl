(define (problem NAMV_tasks)
  (:domain NAMV_operations)

  ;; Objects used in the tasks
  (:objects
    observatory_1 - observatory
    CTD_1 - CTD
    CTD_2 - CTD
    SIMRAD - ship
    OBS_1 - OBS
    OBS_29 - OBS
    temperature_microstructure - instrument
  )

  ;; Initial state
  (:init
    ;; Data not yet downloaded
    (not (data_downloaded observatory_1))

    ;; CTD casts not yet performed
    (not (CTD_performed CTD_1))
    (not (CTD_performed CTD_2))

    ;; Temperature microstructure analysis not yet tested
    (not (microstructure_tested temperature_microstructure))

    ;; Methane plume not yet identified
    (not (methane_plume_identified SIMRAD))

    ;; OBS stations not yet recovered
    (not (OBS_recovered OBS_1))
    (not (OBS_recovered OBS_29))

    ;; Equipment not yet tested
    (not (equipment_tested temperature_microstructure))

    ;; Temperature observatory not yet recovered
    (not (temperature_observatory_recovered observatory_1))
  )

  ;; Goal state
  (:goal
    (and
      ;; Data successfully downloaded
      (data_downloaded observatory_1)

      ;; Successful CTD casts
      (CTD_performed CTD_1)
      (CTD_performed CTD_2)

      ;; Methane plume identified
      (methane_plume_identified SIMRAD)

      ;; OBS recovered
      (OBS_recovered OBS_1)

      ;; Equipment tested
      (equipment_tested temperature_microstructure)

      ;; Temperature observatory recovered
      (temperature_observatory_recovered observatory_1)
    )
  )
)

