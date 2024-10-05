//
//  LeftoverComicBook.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class LeftoverComicBook: SelectedComicBook {
    
    var shoppingList: ShoppingList?
    
    private enum CodingKeys: String, CodingKey {
        case shoppingList = "shopping_list"
    }
    
}
