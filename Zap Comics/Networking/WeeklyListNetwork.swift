//
//  WeeklyListNetwork.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation
import Networking

class WeeklyListNetwork: ZapNetwork {
    
    static func getWeeklyList() async throws -> WeeklyListResponse {
        let response = try await service.get(
            "/weekly_lists/current/by_publisher"
        )
        
        let weeklyListResponse: WeeklyListResponse = try handleResponse(response)
        return weeklyListResponse
    }
}
