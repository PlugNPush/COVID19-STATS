//
//  Data.swift
//  COVID19-STATS
//
//  Created by PlugN on 30/11/2020.
//

import Foundation

class DataValues: Codable {
    
    var date: String?
    var new_cases: Double?
    var new_cases_smoothed: Double?
    var new_deaths: Double?
    var new_deaths_smoothed: Double?
    var new_cases_per_million: Double?
    var new_cases_smoothed_per_million: Double?
    var new_deaths_per_million: Double?
    var stringency_index: Double?
    var total_cases: Double?
    var total_deaths: Double?
    var total_cases_per_million: Double?
    var total_deaths_per_million: Double?
    var reproduction_rate: Double?
    var icu_patients: Double?
    var icu_patients_per_million: Double?
    var hosp_patients: Double?
    var hosp_patients_per_million: Double?
    var weekly_icu_admissions: Double?
    var weekly_icu_admissions_per_million: Double?
    var weekly_hosp_admissions: Double?
    var weekly_hosp_admissions_per_million: Double?
    var total_tests: Double?
    var new_tests: Double?
    var total_tests_per_thousand: Double?
    var new_tests_per_thousand: Double?
    var new_tests_smoothed: Double?
    var new_tests_smoothed_per_thousand: Double?
    var tests_per_case: Double?
    var positive_rate: Double?
    var tests_units: String?
    var extreme_poverty: Double?
    var female_smokers: Double?
    var male_smokers: Double?
    
}
