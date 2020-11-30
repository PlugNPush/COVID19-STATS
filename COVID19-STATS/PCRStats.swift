//
//  PCRStats.swift
//  COVID19-STATS
//
//  Created by PlugN on 30/11/2020.
//

import Foundation
class PCRStats: Codable {
    
    var pcr_positive: Bool?
    var covid_positive: Bool?
    
    static func p(_ positive: [PCRStats], _ total: Int) -> Double {
        return Double(positive.count) / Double(total)
    }
}
