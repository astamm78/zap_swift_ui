//
//  ComicBookNetwork.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import Foundation
import Networking

class ComicBookNetwork: ZapNetwork {
    
    static func addComicBookToList(_ comicBook: ComicBook) async throws -> ComicBookResponse {
        let response = try await service.post(
            "/selected_comic_books",
            parameterType: .json,
            parameters: [
                "selected_comic_books": [
                    "comic_book_id": comicBook.id
                ]
            ]
        )
        
        let comicBookResponse: ComicBookResponse = try handleResponse(response)
        return comicBookResponse
    }
    
    static func removeComicBookFromList(_ comicBook: ComicBook) async throws -> ComicBookResponse {
        let response = try await service.delete("/selected_comic_books/comic_book/\(comicBook.id)")
        
        let comicBookResponse: ComicBookResponse = try handleResponse(response)
        return comicBookResponse
    }
    
    static func updatePurchaseStatus(
        for comicBook: ComicBook,
        and shoppingList: ShoppingList,
        purchased: Bool
    ) async throws -> Bool {
        let response = try await service.put(
            "/selected_comic_books/comic_book/\(comicBook.id)/shopping_list/\(shoppingList.id)",
            parameterType: .json,
            parameters: [
                "selected_comic_book": [
                    "purchased": purchased
                ]
            ]
        )
        
        return handleEmptyResponse(response)
    }
    
}
