(define (domain sopran_project)

  (:requirements :strips :typing :fluents :durative-actions :numeric-fluents)

  (:types 
    station sample profile method equipment)

  (:predicates 
    (ctd_profile_conducted ?station - station)
    (water_sample_collected ?station - station ?depth - number)
    (data_analyzed ?profile - profile ?method - method)
    (halogen_compound_variation_studied ?profile - profile)
    (hydrographic_conditions_understood ?profile - profile)
    (equipment_available ?equipment - equipment)
  )

  (:functions 
    (depth ?station - station) ; Represents the depth of the water sample collection
    (time_spent) ; Total time spent on all tasks
  )

  ;; Durative action to conduct a CTD profile
  (:durative-action conduct_ctd_profile
    :parameters (?station - station)
    :duration (= ?duration 15)
    :condition (and (at start (not (ctd_profile_conducted ?station))))
    :effect (and (at start (ctd_profile_conducted ?station))
                 (at end (increase (time_spent) 15)))
  )

  ;; Durative action to collect water samples at different depths
  (:durative-action collect_water_sample
    :parameters (?station - station ?depth - number)
    :duration (= ?duration 10)
    :condition (and (at start (ctd_profile_conducted ?station))
                    (at start (not (water_sample_collected ?station ?depth))))
    :effect (and (at end (water_sample_collected ?station ?depth))
                 (at end (increase (time_spent) 10)))
  )

  ;; Durative action to analyze data using Method A
  (:durative-action analyze_data_method_a
    :parameters (?profile - profile)
    :duration (= ?duration 20)
    :condition (at start (not (data_analyzed ?profile method_a)))
    :effect (and (at end (data_analyzed ?profile method_a))
                 (at end (increase (time_spent) 20)))
  )

  ;; Durative action to analyze data using Method B (alternative)
  (:durative-action analyze_data_method_b
    :parameters (?profile - profile)
    :duration (= ?duration 25)
    :condition (at start (not (data_analyzed ?profile method_b)))
    :effect (and (at end (data_analyzed ?profile method_b))
                 (at end (increase (time_spent) 25)))
  )

  ;; Durative action to study halogenated compound variations (requires analysis)
  (:durative-action study_halogen_compounds
    :parameters (?profile - profile)
    :duration (= ?duration 30)
    :condition (at start (or (data_analyzed ?profile method_a) (data_analyzed ?profile method_b)))
    :effect (and (at end (halogen_compound_variation_studied ?profile))
                 (at end (increase (time_spent) 30)))
  )

  ;; Durative action to understand hydrographic conditions using equipment
  (:durative-action understand_hydrographic_conditions
    :parameters (?profile - profile ?equipment - equipment)
    :duration (= ?duration 25)
    :condition (and (at start (halogen_compound_variation_studied ?profile))
                    (at start (equipment_available ?equipment)))
    :effect (and (at end (hydrographic_conditions_understood ?profile))
                 (at end (increase (time_spent) 25))
                 (at end (not (equipment_available ?equipment))))
  )
)

