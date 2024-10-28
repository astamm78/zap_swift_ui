//
//  ZapNetwork.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation
import Networking

enum ZapNetworkError: Error {
    case malformedJSON(class: String)
    case networkError(message: String)
}

class ZapNetwork {
    
    static var service: Networking {
        let network = Networking(
            baseURL: "https://zap-list.com/api/v1",
            configuration: .default
        )
        
        var headerFields = [
            "Content-Type": "application/json"
        ]
        
        if let path = Bundle.main.path(forResource: "Networking", ofType: "plist"),
           let keys = NSDictionary(contentsOfFile: path),
           let apiKey = keys["apiKey"] as? String {
            
            headerFields["Authorization"] = apiKey
        }
        
        if let user = User.current {
            headerFields["USER-KEY"] = user.apiKey
        }
        
        network.headerFields = headerFields
        return network
    }
    
    static func handleResponse<T: Codable>(_ response: JSONResult) throws -> T {
        switch response {
        case .success(let successJSONResponse):
            let data = successJSONResponse.data
            do {
                let responseObject: T = try JSONDecoder().decode(T.self, from: data)
                return responseObject
            } catch {
                print(String(describing: T.self))
                throw ZapNetworkError.malformedJSON(class: String(describing: T.self))
            }
        case .failure(let failureJSONResponse):
            print(String(describing: failureJSONResponse.error))
            throw ZapNetworkError.networkError(message: String(describing: failureJSONResponse.error))
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
