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
    @Published var pastLists: [ShoppingList]?

    @Published var selectedTab: DashboardTab = .newComics
    
    private var lastFetchTime_currentList: Date?
    private var lastFetchTime_leftoverList: Date?
    private var lastFetchTime_pastLists: Date?
    
    // 5-minute interval constant in seconds
    private let fetchInterval: TimeInterval = 300
    
    static var shared: DashboardViewModel = DashboardViewModel()
    
    var currentListViewEmpty: Bool {
        let shoppingListEmpty = currentList?.comicBooks.isEmpty ?? true
        let leftoverListEmpty = leftoverList?.comicBooks.isEmpty ?? true
        
        return shoppingListEmpty && leftoverListEmpty
    }
    
    func getWeeklyList() {
        guard WeeklyList.timeToRefresh else {
            self.weeklyList = WeeklyList.current
            return
        }
        
        Task {
            do {
                let weeklyListResponse = try await WeeklyListNetwork.getWeeklyList()
                self.weeklyList = weeklyListResponse.weeklyList
                weeklyListResponse.weeklyList.save()
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func getCurrentList() {
        let currentTime = Date()

        // Check if the last fetch was more than 5 minutes ago
        if let lastFetchTime_currentList, currentTime.timeIntervalSince(lastFetchTime_currentList) < fetchInterval {
            print("Data fetched recently, not making a new API call.")
            return
        }
        
        Task {
            do {
                let currentList = try await ShoppingListNetwork.getShoppingList()
                self.currentList = currentList.shoppingList
                self.lastFetchTime_currentList = Date()
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func getLeftovers() {
        let currentTime = Date()

        // Check if the last fetch was more than 5 minutes ago
        if let lastFetchTime_leftoverList, currentTime.timeIntervalSince(lastFetchTime_leftoverList) < fetchInterval {
            print("Data fetched recently, not making a new API call.")
            return
        }
        
        Task {
            do {
                let leftoverList = try await ShoppingListNetwork.getLeftovers()
                self.leftoverList = leftoverList
                self.lastFetchTime_leftoverList = Date()
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func getPastLists() {
        let currentTime = Date()

        // Check if the last fetch was more than 5 minutes ago
        if let lastFetchTime_pastLists, currentTime.timeIntervalSince(lastFetchTime_pastLists) < fetchInterval {
            print("Data fetched recently, not making a new API call.")
            return
        }
        
        Task {
            do {
                let pastListsResponse = try await ShoppingListNetwork.getPastLists()
                self.pastLists = pastListsResponse.shoppingLists
                self.lastFetchTime_pastLists = Date()
            } catch {
                print(String(describing: error))
            }
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
            do {
                let _ = try await ComicBookNetwork.addComicBookToList(comicBook)
                
                weeklyList?.updateComicBookSelected(comicBook)
                weeklyList?.save()
                
                getCurrentList()
                getLeftovers()
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func removeComicBookFromList(_ comicBook: ComicBook) {
        Task {
            do {
                let _ = try await ComicBookNetwork.removeComicBookFromList(comicBook)
                
                weeklyList?.updateComicBookSelected(comicBook)
                weeklyList?.save()
                
                getCurrentList()
                getLeftovers()
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func markComicBookPurchased(_ comicBook: ComicBook) {
        guard let shoppingList = comicBook.shoppingList ?? currentList else { return }
        
        Task {
            do {
                let _ = try await ComicBookNetwork.updatePurchaseStatus(
                    for: comicBook,
                    and: shoppingList,
                    purchased: !comicBook.purchased
                )
                
                weeklyList?.updateComicBookPurchased(comicBook)
                weeklyList?.save()
                
                currentList?.updateComicBookPurchased(comicBook)
                leftoverList?.updateComicBookPurchased(comicBook)
            } catch {
                print(String(describing: error))
            }
        }
    }
}
