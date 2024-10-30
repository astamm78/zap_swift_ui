//
//  ZapResponseHandler.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/30/24.
//

import Foundation
import Networking

enum ZapNetworkError: Error {
    case malformedJSON(class: String)
    case networkError(message: String)
}

struct ZapResponseHandler {
    
    static var shared = ZapResponseHandler()
    
    func handleResponse<T: Codable>(_ response: JSONResult) throws -> T {
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
    
    func handleEmptyResponse(_ response: JSONResult) -> Bool {
        switch response {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
}
