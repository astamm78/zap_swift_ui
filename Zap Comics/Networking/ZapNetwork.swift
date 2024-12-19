//
//  ZapNetwork.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation
import Networking

struct ZapNetwork {
    
    static func service() -> Networking {
        let network = Networking(
            baseURL: "https://zap-list.com/api/v1",
            configuration: .default
        )
        
        var headerFields = [
            "Content-Type": "application/json"
        ]
        
        if let apiKey = Secrets.apiKey {
            headerFields["Authorization"] = apiKey
        }
        
        if let user = User.current {
            headerFields["USER-KEY"] = user.apiKey
        }
        
        print(String(describing: headerFields))
        
        network.headerFields = headerFields
        return network
    }

}
