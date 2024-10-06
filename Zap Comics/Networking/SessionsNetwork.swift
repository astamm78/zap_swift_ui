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
        
        let userResponse: UserResponse? = handleResponse(response)
        return userResponse
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
         
        let userResponse: UserResponse? = handleResponse(response)
        return userResponse
    }
    
}
