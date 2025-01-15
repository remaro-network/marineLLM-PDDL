(define (problem auv_camera_mission_problem)
  (:domain auv_camera_mission)
  
  (:objects
    anton85 anton86 anton87 - auv
    fixed_camera automatic_camera - setting
  )
  
  (:init
    (= (depth anton85) 40)
    (= (depth anton86) 40)
    (= (depth anton87) 40)
    (camera_fixed anton85)
    (camera_automatic anton86)
    (camera_fixed anton87)
  )
  
  (:goal
    (and
      (mission_completed anton85)
      (mission_completed anton86)
      (mission_completed anton87)
      (image_captured anton85)
      (image_captured anton86)
      (image_captured anton87)
    )
  )
)

