//
//  DashboardViewModel.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var selectedPublisher: Publisher? = nil
    @Published var selectedComicBook: ComicBook? = nil
    @Published var showSheet = false
    
    @Published var weeklyList: WeeklyList?
    @Published var currentList: ShoppingList?
    @Published var leftoverList: LeftoverList?

    @Published var currentListViewEmpty: Bool = false
    
    @Published var selectedTab: DashboardTab = .newComics
    
    func getWeeklyList() {
        Task {
            guard let weeklyListResponse = try? await WeeklyListNetwork.getWeeklyList() else { return }
            
            self.weeklyList = weeklyListResponse.weeklyList
        }
    }
    
    func getCurrentList() {
        Task {
            guard let currentList = try? await ShoppingListNetwork.getShoppingList() else { return }
            
            self.currentList = currentList.shoppingList
        }
    }
    
    func getLeftovers() {
        Task {
            guard let leftoverList = try? await ShoppingListNetwork.getLeftovers() else {
                self.leftoverList = nil
                return
            }
            
            self.leftoverList = leftoverList
        }
    }
    
    func select(_ publisher: Publisher) {
        if selectedPublisher == publisher {
            selectedPublisher = nil
        } else {
            self.selectedPublisher = publisher
        }
    }
    
    func select(_ comicBook: ComicBook) {
        if selectedComicBook == comicBook {
            selectedComicBook = nil
            showSheet = false
        } else {
            self.selectedComicBook = comicBook
            showSheet = true
        }
    }
    
    func dismisSheet() {
        selectedComicBook = nil
        showSheet = false
    }
    
    func comicBookActionTapped(_ comicBook: ComicBook, isPurchaseView: Bool) {
        if comicBook.selected || isPurchaseView {
            removeComicBookFromList(comicBook)
        } else {
            addComicBookToList(comicBook)
        }
    }
    
    func addComicBookToList(_ comicBook: ComicBook) {
        Task {
            guard let _ = try? await ComicBookNetwork.addComicBookToList(comicBook) else { return }
        
            weeklyList?.updateComicBookSelected(comicBook)
            
            getCurrentList()
            getLeftovers()
        }
    }
    
    func removeComicBookFromList(_ comicBook: ComicBook) {
        Task {
            guard let _ = try? await ComicBookNetwork.removeComicBookFromList(comicBook) else { return }
            
            weeklyList?.updateComicBookSelected(comicBook)
            
            getCurrentList()
            getLeftovers()
        }
    }
    
    func markComicBookPurchased(_ comicBook: ComicBook) {
        guard let shoppingList = comicBook.shoppingList ?? currentList else { return }
        
        Task {
            guard let _ = try? await ComicBookNetwork.updatePurchaseStatus(
                for: comicBook,
                and: shoppingList,
                purchased: !comicBook.purchased
            ) else {
                return
            }
            
            weeklyList?.updateComicBookPurchased(comicBook)
            currentList?.updateComicBookPurchased(comicBook)
            leftoverList?.updateComicBookPurchased(comicBook)
        }
    }
}
