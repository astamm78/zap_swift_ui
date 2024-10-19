//
//  RecentListsView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct RecentListsView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    
    var body: some View {
        LoadableView(content: {
            EmptyStateView(content: {
                ScrollView {
                    LazyVStack(
                        alignment: .leading,
                        spacing: 0,
                        pinnedViews: .sectionHeaders) {
                            if let pastLists = viewModel.pastLists {
                                ForEach(pastLists) { shoppingList in
                                    Section {
                                        ForEach(shoppingList.comicBooks) { comicBook in
                                            ComicBookCell(comicBook: comicBook)
                                                .setPastListView()
                                        }
                                    } header: {
                                        CurrentListHeader(title: shoppingList.dateString)
                                    }
                                }
                            }
                        }
                }
            }, message: "You don't have any recent lists.", dataPresent: viewModel.pastLists != nil)
        }, loadingComplete: viewModel.pastLists != nil)
        .task {
            viewModel.getPastLists()
        }
    }
}

#Preview {
    RecentListsView()
        .environmentObject(DashboardViewModel())
}
