//
//  WeeklyList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class WeeklyList: Codable {
    
    let dateFormatter = DateFormatter()
    
    var id: Int
    var dateString: String
    var publishers: [Publisher]
    
    var date: Date {
        dateFormatter.date(from: dateString)!
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case dateString = "date"
        case publishers
    }
    
}
