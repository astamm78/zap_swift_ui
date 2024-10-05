//
//  SessionsNetwork.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation
import Networking

class SessionsNetwork: ZapNetwork {
    
    static func login(with username: String, and password: String) async throws -> UserResponse? {
        let response = try await service.post(
            "/sessions",
            parameterType: .json,
            parameters: [
                "user": [
                    "username": username,
                    "password": password
                ]
            ]
        )
        
        return handleSessionsResponse(response: response)
    }
    
    static func register(with username: String, and password: String) async throws -> UserResponse? {
        let response = try await service.post(
            "/users",
            parameterType: .json,
            parameters: [
                "user": [
                    "username": username,
                    "password": password
                ]
            ]
        )
         
        return handleSessionsResponse(response: response)
    }
    
    private static func handleSessionsResponse(response: JSONResult) -> UserResponse? {
        switch response {
        case .success(let successJSONResponse):
            let data = successJSONResponse.data
            let userResponse: UserResponse? = try? JSONDecoder().decode(UserResponse.self, from: data)
            return userResponse
        case .failure(let failureJSONResponse):
            print("Login Error - \(failureJSONResponse.error)")
            return nil
        }
    }
    
}
