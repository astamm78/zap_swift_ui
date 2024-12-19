//
//  SessionsNetwork.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation
import Networking

struct SessionsNetwork {
    
    func login(with username: String, and password: String) async throws -> UserResponse {
        let response = try await ZapNetwork.service().post(
            "/sessions",
            parameterType: .json,
            parameters: [
                "user": [
                    "username": username,
                    "password": password
                ]
            ]
        )
        
        let userResponse: UserResponse = try ZapResponseHandler.shared.handleResponse(response)
        return userResponse
    }
    
    func register(with username: String, and password: String) async throws -> UserResponse {
        let response = try await ZapNetwork.service().post(
            "/users",
            parameterType: .json,
            parameters: [
                "user": [
                    "username": username,
                    "password": password
                ]
            ]
        )
         
        let userResponse: UserResponse = try ZapResponseHandler.shared.handleResponse(response)
        return userResponse
    }
    
    func deleteAccount() async throws -> Bool {
        guard let user = User.current else { return false }
        
        let response = try await ZapNetwork.service().delete("/users/\(user.id)")
        
        return ZapResponseHandler.shared.handleEmptyResponse(response)
    }
    
}
