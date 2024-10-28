//
//  NewComicsView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct NewComicsView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    
    private var searchResults: [ComicBook] {
        guard !viewModel.searchText.isEmpty else {
            return []
        }
        
        return viewModel.weeklyList?.filterContentForSearchText(viewModel.searchText) ?? []
    }
    
    var body: some View {
        NavigationStack {
            LoadableView(content: {
                ScrollView {
                    LazyVStack(
                        alignment: .leading,
                        spacing: 0,
                        pinnedViews: .sectionHeaders
                    ) {
                        Button("Crash") {
                          fatalError("Crash was triggered")
                        }
                        
                        if searchResults.isEmpty {
                            publisherView
                        } else {
                            searchResultsView
                        }
                    }
                    .sheet(
                        isPresented: $viewModel.showSheet) {
                            viewModel.selectedComicBook.map { comicBook in
                                ComicBookDetailView(comicBook: comicBook)
                            }
                        }
                }
                .accessibilityIdentifier(TestingIdentifiers.NewComicsView.newComicsView)
                .refreshable {
                    viewModel.weeklyList = nil
                    viewModel.getWeeklyList(force: true)
                }
            }, loadingComplete: viewModel.weeklyList != nil)
            .navigationTitle(viewModel.weeklyList?.dateDisplay ?? "")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $viewModel.searchText)
    }
    
    var publisherView: some View {
        viewModel.weeklyList.map { weeklyList in
            ForEach(weeklyList.publishers) { publisher in
                Section {
                    if viewModel.selectedPublisher == publisher {
                        ForEach(publisher.comicBooks) { comicBook in
                            ComicBookCell(comicBook: comicBook)
                        }
                    }
                } header: {
                    PublisherHeader(publisher: publisher)
                        .onTapGesture {
                            withAnimation {
                                viewModel.select(publisher)
                            }
                        }
                }
            }
        }
    }
    
    var searchResultsView: some View {
        ForEach(searchResults) { comicBook in
            ComicBookCell(comicBook: comicBook)
        }
    }
}

#Preview {
    let vm = DashboardViewModel()
    vm.weeklyList = WeeklyList.preview
    
    return NewComicsView()
        .environmentObject(vm)
}
