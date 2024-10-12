//
//  DashboardViewModel.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var weeklyList: WeeklyList?
    @Published var selectedPublisher: Publisher? = nil
    @Published var selectedComicBook: ComicBook? = nil
    @Published var showSheet = false
    
    @Published var currentList: ShoppingList?
    @Published var leftoverList: LeftoverList?

    @Published var dataLoaded: Bool = false

    var finishedNetworkRequests: [String] = [] {
        didSet {
            if finishedNetworkRequests.count >= 3 {
                dataLoaded = true
            }
        }
    }

    init() {
        getWeeklyList()
        getCurrentList()
        getLeftovers()
    }
    
    private func getWeeklyList() {
        Task {
            guard let weeklyListResponse = try? await WeeklyListNetwork.getWeeklyList() else { return }
            
            self.weeklyList = weeklyListResponse.weeklyList
            self.finishedNetworkRequests.append("Weekly List")
        }
    }
    
    private func getCurrentList() {
        Task {
            guard let currentList = try? await ShoppingListNetwork.getShoppingList() else { return }
            
            self.currentList = currentList.shoppingList.allComicsSelected()
            self.finishedNetworkRequests.append("Current List")
        }
    }
    
    private func getLeftovers() {
        Task {
            guard var leftoverList = try? await ShoppingListNetwork.getLeftovers() else {
                self.leftoverList = nil
                return
            }
            
            self.leftoverList = leftoverList.allComicsSelected()
            self.finishedNetworkRequests.append("Leftovers")
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
    
    func comicBookActionTapped(_ comicBook: ComicBook) {
        comicBook.selected ? removeComicBookFromList(comicBook) : addComicBookToList(comicBook)
    }
    
    func addComicBookToList(_ comicBook: ComicBook) {
        guard let weeklyList else { return }
        
        Task {
            guard let comicBookResponse = try? await ComicBookNetwork.addComicBookToList(comicBook) else { return }
        
            let updatedList = weeklyList.updateComicBook(comicBook)

            self.weeklyList = updatedList
            self.getCurrentList()
        }
    }
    
    func removeComicBookFromList(_ comicBook: ComicBook) {
        guard let weeklyList else { return }
        
        Task {
            guard let comicBookResponse = try? await ComicBookNetwork.removeComicBookFromList(comicBook) else { return }
            
            let updatedList = weeklyList.updateComicBook(comicBook)

            self.weeklyList = updatedList
            self.getCurrentList()
        }
    }
    
    func markComicBookPurchased(_ comicBook: ComicBook) {
        guard let weeklyList,
              let shoppingList = comicBook.shoppingList ?? currentList else { return }

        Task {
            guard let _ = try? await ComicBookNetwork.updatePurchaseStatus(
                for: comicBook,
                and: shoppingList,
                purchased: !comicBook.purchased
            ) else {
                return
            }

            let updatedList = weeklyList.updateComicBook(comicBook)
            self.weeklyList = updatedList

            let updatedLeftovers = leftoverList?.updateComicBook(comicBook)
            self.leftoverList = updatedLeftovers
        }
    }
}
