(define (domain auv_mission)

  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types 
    auv mission task procedure equipment)

  (:predicates 
    (prepared_for_mission ?auv - auv)
    (dive_performed ?auv - auv ?mission - mission)
    (data_collected ?auv - auv ?mission - mission)
    (technical_issue_identified ?auv - auv ?mission - mission)
    (usbl_navigation_used ?auv - auv ?mission - mission)
    (rendezvous_completed ?auv - auv ?other_auv - auv)
    (thruster_performance_measured ?auv - auv)
    (video_footage_captured ?auv - auv)
    (rescue_buoy_tested ?auv - auv)
  )

  (:functions 
    (energy_level ?auv - auv)
    (time_spent) ; Total time spent on all tasks
  )

  ;; Durative action to prepare an AUV for a mission
  (:durative-action prepare_auv_for_mission
    :parameters (?auv - auv)
    :duration (= ?duration 10)
    :condition (at start (not (prepared_for_mission ?auv)))
    :effect (and (at end (prepared_for_mission ?auv))
                 (at end (increase (time_spent) 10)))
  )

  ;; Durative action to perform a dive and collect data
  (:durative-action perform_dive_and_collect_data
    :parameters (?auv - auv ?mission - mission)
    :duration (= ?duration 30)
    :condition (and (at start (prepared_for_mission ?auv))
                    (at start (not (dive_performed ?auv ?mission))))
    :effect (and (at end (dive_performed ?auv ?mission))
                 (at end (data_collected ?auv ?mission))
                 (at end (increase (time_spent) 30)))
  )

  ;; Durative action to identify technical issues during a mission
  (:durative-action identify_technical_issues
    :parameters (?auv - auv ?mission - mission)
    :duration (= ?duration 20)
    :condition (and (at start (dive_performed ?auv ?mission))
                    (at start (not (technical_issue_identified ?auv ?mission))))
    :effect (and (at end (technical_issue_identified ?auv ?mission))
                 (at end (increase (time_spent) 20)))
  )

  ;; Durative action to use USBL-driven navigation
  (:durative-action use_usbl_navigation
    :parameters (?auv - auv ?mission - mission)
    :duration (= ?duration 15)
    :condition (and (at start (dive_performed ?auv ?mission))
                    (at start (not (usbl_navigation_used ?auv ?mission))))
    :effect (and (at end (usbl_navigation_used ?auv ?mission))
                 (at end (increase (time_spent) 15)))
  )

  ;; Durative action to perform a rendezvous between two AUVs
  (:durative-action perform_rendezvous
    :parameters (?auv - auv ?other_auv - auv)
    :duration (= ?duration 25)
    :condition (and (at start (prepared_for_mission ?auv))
                    (at start (prepared_for_mission ?other_auv))
                    (at start (not (rendezvous_completed ?auv ?other_auv))))
    :effect (and (at end (rendezvous_completed ?auv ?other_auv))
                 (at end (increase (time_spent) 25)))
  )

  ;; Durative action to measure thruster performance
  (:durative-action measure_thruster_performance
    :parameters (?auv - auv)
    :duration (= ?duration 15)
    :condition (and (at start (dive_performed ?auv mission1)) ; Assuming mission1 is the relevant mission
                    (at start (not (thruster_performance_measured ?auv))))
    :effect (and (at end (thruster_performance_measured ?auv))
                 (at end (increase (time_spent) 15)))
  )

  ;; Durative action to capture video footage
  (:durative-action capture_video_footage
    :parameters (?auv - auv)
    :duration (= ?duration 20)
    :condition (and (at start (dive_performed ?auv mission2)) ; Assuming mission2 is the relevant mission
                    (at start (not (video_footage_captured ?auv))))
    :effect (and (at end (video_footage_captured ?auv))
                 (at end (increase (time_spent) 20)))
  )

  ;; Durative action to test the release of the rescue buoy
  (:durative-action test_rescue_buoy
    :parameters (?auv - auv)
    :duration (= ?duration 10)
    :condition (and (at start (dive_performed ?auv mission3)) ; Assuming mission3 is the relevant mission
                    (at start (not (rescue_buoy_tested ?auv))))
    :effect (and (at end (rescue_buoy_tested ?auv))
                 (at end (increase (time_spent) 10)))
  )
)

