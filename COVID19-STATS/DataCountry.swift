//
//  DataCountry.swift
//  COVID19-STATS
//
//  Created by PlugN on 30/11/2020.
//

import Foundation

class DataCountry: Codable {
    
    var continent: String?
    var location: String?
    var population: Double?
    var population_density: Double?
    var median_age: Double?
    var aged_65_older: Double?
    var aged_70_older: Double?
    var gdp_per_capita: Double?
    var cardiovasc_death_rate: Double?
    var handwashing_facilities: Double?
    var hospital_beds_per_thousand: Double?
    var life_expectancy: Double?
    var human_development_index: Double?
    var diabetes_prevalence: Double?
    var data: [DataValues?]
    var cases: Double {
        return data.map({ $0?.new_cases ?? 0}).reduce(0, +)
    }
    var deaths: Double {
        return data.map({ $0?.new_deaths ?? 0}).reduce(0, +)
    }
    var tests: Double {
        return data.map({ $0?.new_tests ?? 0}).reduce(0, +)
    }
    var testsByCase: Double {
        let result = data.map({ $0?.tests_per_case ?? 0})
        let count = Double(result.count)
        return result.reduce(0, +) / count
    }
    var positiveRate: Double {
        let result = data.map({ $0?.positive_rate ?? 0})
        let count = Double(result.count)
        return result.reduce(0, +) / count
    }
    
}
