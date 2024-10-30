//
//  ShoppingListNetwork.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import Foundation
import Networking

struct ShoppingListNetwork {
    
    func getShoppingList() async throws -> ShoppingListResponse {
        let response = try await ZapNetwork.shared.service.get("/shopping_lists/current")
        
        let shoppingListResponse: ShoppingListResponse = try ZapResponseHandler.shared.handleResponse(response)
        return shoppingListResponse
    }
    
    func getLeftovers() async throws -> LeftoverList {
        let response = try await ZapNetwork.shared.service.get("/shopping_lists/leftover")
        
        let leftoverList: LeftoverList = try ZapResponseHandler.shared.handleResponse(response)
        return leftoverList
    }
    
    func getPastLists() async throws -> ShoppingListCollectionResponse {
        let response = try await ZapNetwork.shared.service.get("/shopping_lists/past_lists")
        
        let pastListsResponse: ShoppingListCollectionResponse = try ZapResponseHandler.shared.handleResponse(response)
        return pastListsResponse
    }
}
