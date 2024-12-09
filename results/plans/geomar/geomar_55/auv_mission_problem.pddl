(define (problem auv_mission_problem)
  (:domain auv_mission)

  (:objects
    auv1 auv2 - auv
    mission1 mission2 mission3 - mission
  )

  (:init
    (not (prepared_for_mission auv1))
    (not (prepared_for_mission auv2))
    (not (dive_performed auv1 mission1))
    (not (dive_performed auv2 mission2))
    (not (dive_performed auv1 mission3))
    (not (data_collected auv1 mission1))
    (not (data_collected auv2 mission2))
    (not (technical_issue_identified auv1 mission1))
    (not (usbl_navigation_used auv1 mission1))
    (not (rendezvous_completed auv1 auv2))
    (not (thruster_performance_measured auv1))
    (not (video_footage_captured auv2))
    (not (rescue_buoy_tested auv1))
    (= (time_spent) 0)
    (= (energy_level auv1) 100)
    (= (energy_level auv2) 100)
  )

  (:goal
    (and
      (prepared_for_mission auv1)
      (prepared_for_mission auv2)
      (dive_performed auv1 mission1)
      (dive_performed auv2 mission2)
      (data_collected auv1 mission1)
      (data_collected auv2 mission2)
      (technical_issue_identified auv1 mission1)
      (usbl_navigation_used auv1 mission1)
      (rendezvous_completed auv1 auv2)
      (thruster_performance_measured auv1)
      (video_footage_captured auv2)
      (rescue_buoy_tested auv1)
    )
  )
)

