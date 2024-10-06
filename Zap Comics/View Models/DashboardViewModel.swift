//
//  NewComicsViewModel.swift
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
    
    init() {
        getWeeklyList()
    }
    
    private func getWeeklyList() {
        Task {
            guard let weeklyListResponse = try? await WeeklyListNetwork.getWeeklyList() else { return }
            
            self.weeklyList = weeklyListResponse.weeklyList
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
}
