(define (problem sopran_project_problem)
  (:domain sopran_project)
  
  (:objects
    station1 station2 station3 - station
    profile1 profile2 profile3 - profile
    depth10 depth20 depth30 - number
    method_a method_b - method
    equipment1 equipment2 - equipment
  )
  
  (:init
    (= (depth station1) 10)
    (= (depth station2) 20)
    (= (depth station3) 30)
    (equipment_available equipment1)
    (equipment_available equipment2)
    (= (time_spent) 0)
  )
  
  (:goal
    (and
      (ctd_profile_conducted station1)
      (ctd_profile_conducted station2)
      (ctd_profile_conducted station3)
      (water_sample_collected station1 depth10)
      (water_sample_collected station2 depth20)
      (water_sample_collected station3 depth30)
      (or (data_analyzed profile1 method_a) (data_analyzed profile1 method_b))
      (or (data_analyzed profile2 method_a) (data_analyzed profile2 method_b))
      (or (data_analyzed profile3 method_a) (data_analyzed profile3 method_b))
      (halogen_compound_variation_studied profile1)
      (halogen_compound_variation_studied profile2)
      (halogen_compound_variation_studied profile3)
      (hydrographic_conditions_understood profile1)
      (hydrographic_conditions_understood profile2)
      (hydrographic_conditions_understood profile3)
    )
  )
)

