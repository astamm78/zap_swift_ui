//
//  DashboardView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

enum DashboardTab: Int, CaseIterable, Identifiable {
    var id: Int {
        self.rawValue
    }
    
    case newComics
    case currentList
    case recentLists
    case storeFinder
    
    var displayName: String {
        switch self {
        case .newComics: return "New Comics"
        case .currentList: return "Current List"
        case .recentLists: return "Recent Lists"
        case .storeFinder: return "Store Finder"
        }
    }
    
    var tabView: some View {
        switch self {
        case .newComics:
            return AnyView(NewComicsView())
        case .currentList:
            return AnyView(CurrentListView())
        case .recentLists:
            return AnyView(RecentListsView())
        case .storeFinder:
            return AnyView(FindAStoreView())
        }
    }
    
    var iconName: String {
        switch self {
        case .newComics: return "icon-weekly_list"
        case .currentList: return "icon-pull_list"
        case .recentLists: return "icon-past_lists"
        case .storeFinder: return "icon-find_store"
        }
    }
    
    var testingIdentifier: String {
        switch self {
        case .newComics:
            TestingIdentifiers.Dashboard.newComicsTabButton
        case .currentList:
            TestingIdentifiers.Dashboard.currentListTabButton
        case .recentLists:
            TestingIdentifiers.Dashboard.pastListsTabButton
        case .storeFinder:
            TestingIdentifiers.Dashboard.storeFinderTabButton
        }
    }
}

struct DashboardView: View {
    @EnvironmentObject var contentVM: ContentViewModel
    @EnvironmentObject var dashboardVM: DashboardViewModel
    
    var body: some View {
        TabView(selection: $dashboardVM.selectedTab) {
            ZapTabNav(dashboardTab: .newComics)
                .tag(DashboardTab.newComics)
                .onAppear {
                    dashboardVM.selectedTab = .newComics
                }

            ZapTabNav(dashboardTab: .currentList)
                .tag(DashboardTab.currentList)
                .onAppear {
                    dashboardVM.selectedTab = .currentList
                }

            ZapTabNav(dashboardTab: .recentLists)
                .tag(DashboardTab.recentLists)
                .onAppear {
                    dashboardVM.selectedTab = .recentLists
                }
            
            ZapTabNav(dashboardTab: .storeFinder)
                .tag(DashboardTab.storeFinder)
                .onAppear {
                    dashboardVM.selectedTab = .storeFinder
                }
        }
    }
}

#Preview {
    let dVM = DashboardViewModel()

    return DashboardView()
        .environmentObject(ContentViewModel())
        .environmentObject(dVM)
}
