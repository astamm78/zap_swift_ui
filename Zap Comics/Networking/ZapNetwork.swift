//
//  ZapNetwork.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation
import Networking

class ZapNetwork {
    
    static var service: Networking {
        let network = Networking(
            baseURL: "https://zap-list.com/api/v1",
            configuration: .default
        )
        
        var headerFields = [
            "Content-Type": "application/json",
            "Authorization": "***REMOVED***"
        ]
        
        if let user = User.current {
            headerFields["USER-KEY"] = user.apiKey
        }
        
        network.headerFields = headerFields
        return network
    }
    
    static func handleResponse<T: Codable>(_ response: JSONResult) -> T? {
        switch response {
        case .success(let successJSONResponse):
            let data = successJSONResponse.data
            do {
                let responseObject: T? = try JSONDecoder().decode(T.self, from: data)
                return responseObject
            } catch {
                print(String(describing: error))
                return nil
            }
        case .failure(let failureJSONResponse):
            print("Login Error - \(failureJSONResponse.error)")
            return nil
        }
    }
    
    static func handleEmptyResponse(_ response: JSONResult) -> Bool {
        switch response {
        case .success:
            return true
        case .failure:
            return false
        }
    }

}
