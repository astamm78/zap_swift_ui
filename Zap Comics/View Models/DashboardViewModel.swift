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
    
    init() {
        getWeeklyList()
        getCurrentList()
    }
    
    private func getWeeklyList() {
        Task {
            guard let weeklyListResponse = try? await WeeklyListNetwork.getWeeklyList() else { return }
            
            self.weeklyList = weeklyListResponse.weeklyList
        }
    }
    
    private func getCurrentList() {
        Task {
            guard let currentList = try? await ShoppingListNetwork.getShoppingList() else { return }
            
            self.currentList = currentList.shoppingList.allComicsSelected()
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
        
            let mutableWeeklyList = weeklyList
            mutableWeeklyList.updateComicBook(comicBookResponse.addedComicBook)
            
            self.weeklyList = mutableWeeklyList
            self.getCurrentList()
        }
    }
    
    func removeComicBookFromList(_ comicBook: ComicBook) {
        guard let weeklyList else { return }
        
        Task {
            guard let comicBookResponse = try? await ComicBookNetwork.removeComicBookFromList(comicBook) else { return }
            
            let mutableWeeklyList = weeklyList
            mutableWeeklyList.updateComicBook(comicBookResponse.addedComicBook)
            
            self.weeklyList = mutableWeeklyList
            self.getCurrentList()
        }
    }
}
