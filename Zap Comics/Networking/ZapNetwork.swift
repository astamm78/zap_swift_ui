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
    
}
