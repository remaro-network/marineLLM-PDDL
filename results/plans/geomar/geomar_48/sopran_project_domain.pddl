(define (domain sopran_project)

  (:requirements :strips :typing :fluents :durative-actions)

  (:types 
    station sample profile)

  (:predicates 
    (ctd_profile_conducted ?station - station)
    (water_sample_collected ?station - station ?depth - number)
    (data_analyzed ?profile - profile)
    (halogen_compound_variation_studied ?profile - profile)
    (hydrographic_conditions_understood ?profile - profile)
  )

  (:functions 
    (depth ?station - station) ; Represents the depth of the water sample collection
  )

  ;; Durative action to conduct a CTD profile
  (:durative-action conduct_ctd_profile
    :parameters (?station - station)
    :duration (= ?duration 15)
    :condition (and (at start (not (ctd_profile_conducted ?station))))
    :effect (and (at start (ctd_profile_conducted ?station)))
  )

  ;; Durative action to collect water samples at different depths using Niskin bottles
  (:durative-action collect_water_sample
    :parameters (?station - station ?depth - number)
    :duration (= ?duration 10)
    :condition (and (at start (ctd_profile_conducted ?station))
                    (at start (not (water_sample_collected ?station ?depth))))
    :effect (and (at end (water_sample_collected ?station ?depth)))
  )

  ;; Durative action to analyze the collected data for temperature, salinity, and oxygen levels
  (:durative-action analyze_data
    :parameters (?profile - profile)
    :duration (= ?duration 20)
    :condition (at start (not (data_analyzed ?profile)))
    :effect (at end (data_analyzed ?profile))
  )

  ;; Durative action to study halogenated compound variations
  (:durative-action study_halogen_compounds
    :parameters (?profile - profile)
    :duration (= ?duration 30)
    :condition (at start (data_analyzed ?profile))
    :effect (at end (halogen_compound_variation_studied ?profile))
  )

  ;; Durative action to understand hydrographic conditions
  (:durative-action understand_hydrographic_conditions
    :parameters (?profile - profile)
    :duration (= ?duration 25)
    :condition (at start (data_analyzed ?profile))
    :effect (at end (hydrographic_conditions_understood ?profile))
  )
)

