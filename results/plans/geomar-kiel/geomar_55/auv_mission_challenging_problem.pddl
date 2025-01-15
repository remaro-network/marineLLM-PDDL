(define (problem auv_mission_challenging_problem)
  (:domain auv_mission)

  (:objects
    auv1 auv2 - auv
    mission1 mission2 mission3 mission4 mission5 - mission
    equipment1 equipment2 equipment3 - equipment
  )

  (:init
    ;; Initial preparation state
    (not (prepared_for_mission auv1))
    (not (prepared_for_mission auv2))

    ;; Initial mission states
    (not (dive_performed auv1 mission1))
    (not (dive_performed auv2 mission2))
    (not (dive_performed auv1 mission3))
    (not (dive_performed auv2 mission4))
    (not (dive_performed auv1 mission5))

    ;; Data collection and technical issues
    (not (data_collected auv1 mission1))
    (not (data_collected auv2 mission2))
    (not (data_collected auv1 mission3))
    (not (data_collected auv2 mission4))
    (not (technical_issue_identified auv1 mission1))
    (not (technical_issue_identified auv2 mission2))

    ;; USBL Navigation and specific technical tasks
    (not (usbl_navigation_used auv1 mission1))
    (not (usbl_navigation_used auv2 mission2))
    (not (rendezvous_completed auv1 auv2))
    (not (thruster_performance_measured auv1))
    (not (video_footage_captured auv2))
    (not (rescue_buoy_tested auv1))

    ;; Resource constraints
    (= (time_spent) 0)
    (= (energy_level auv1) 80) ; Reduced energy level for more challenge
    (= (energy_level auv2) 70)

    ;; Equipment availability
    (not (prepared_for_mission equipment1))
    (not (prepared_for_mission equipment2))
    (not (prepared_for_mission equipment3))
  )

  (:goal
    (and
      ;; Both AUVs must complete at least 2 missions each
      (dive_performed auv1 mission1)
      (dive_performed auv2 mission2)
      (dive_performed auv1 mission3)
      (dive_performed auv2 mission4)

      ;; Data collection and issue identification goals
      (data_collected auv1 mission1)
      (data_collected auv2 mission2)
      (technical_issue_identified auv1 mission1)
      (technical_issue_identified auv2 mission2)

      ;; USBL navigation is required for at least one mission
      (usbl_navigation_used auv1 mission1)
      
      ;; Perform a synchronized rendezvous
      (rendezvous_completed auv1 auv2)

      ;; Specific technical tasks must be performed
      (thruster_performance_measured auv1)
      (video_footage_captured auv2)
      (rescue_buoy_tested auv1)

      ;; All goals must be completed within available energy and time constraints
      (<= (time_spent) 100)
      (>= (energy_level auv1) 0)
      (>= (energy_level auv2) 0)
    )
  )
)

