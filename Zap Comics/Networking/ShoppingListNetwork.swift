//
//  ShoppingListNetwork.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import Foundation
import Networking

class ShoppingListNetwork: ZapNetwork {
    
    static func getShoppingList() async throws -> ShoppingListResponse {
        let response = try await service.get("/shopping_lists/current")
        
        let shoppingListResponse: ShoppingListResponse = try handleResponse(response)
        return shoppingListResponse
    }
    
    static func getLeftovers() async throws -> LeftoverList {
        let response = try await service.get("/shopping_lists/leftover")
        
        let leftoverList: LeftoverList = try handleResponse(response)
        return leftoverList
    }
    
}
