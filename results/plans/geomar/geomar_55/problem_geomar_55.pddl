(define (problem jago_dive_problem)
  (:domain jago_dive_operations)
  
  (:objects
    jago - submersible
    vessel_base - vessel
    site1 site2 site3 site4 - site
    pilot_peter - pilot
    observer_daniele - observer
    sample1 sample2 sample3 - sample
    dive1 dive2 dive3 dive4 dive5 dive6 dive7 - dive
    auv1 - auv
    thruster1 thruster2 - thruster
  )
  
  (:init
    (submersible_ready jago)
    (at jago site1)
  )
  
  (:goal
    (and
      (pilot_trained pilot_peter)
      (video_captured dive1)
      (sample_collected dive1 sample1)
      (thruster_performance_measured dive2 thruster1)
      (rendezvous_completed dive3 auv1)
      (rescue_buoy_tested dive7)
    )
  )
)

