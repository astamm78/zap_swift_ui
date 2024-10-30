//
//  WeeklyListNetwork.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation
import Networking

struct WeeklyListNetwork {
    
    func getWeeklyList() async throws -> WeeklyListResponse {
        let response = try await ZapNetwork.shared.service.get(
            "/weekly_lists/current/by_publisher"
        )
        
        let weeklyListResponse: WeeklyListResponse = try ZapResponseHandler.shared.handleResponse(response)
        return weeklyListResponse
    }
}
