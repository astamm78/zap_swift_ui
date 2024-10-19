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
        Task {
            do {
                let currentList = try await ShoppingListNetwork.getShoppingList()
                self.currentList = currentList.shoppingList
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func getLeftovers() {
        Task {
            do {
                let leftoverList = try await ShoppingListNetwork.getLeftovers()
                self.leftoverList = leftoverList
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func getPastLists() {
        Task {
            do {
                let pastListsResponse = try await ShoppingListNetwork.getPastLists()
                self.pastLists = pastListsResponse.shoppingLists
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
