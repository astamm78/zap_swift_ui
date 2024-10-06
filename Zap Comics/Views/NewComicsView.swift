//
//  NewComicsView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct NewComicsView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading,
                spacing: 0,
                pinnedViews: .sectionHeaders
            ) {
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
                .sheet(
                    isPresented: $viewModel.showSheet) {
                        viewModel.selectedComicBook.map { comicBook in
                            ZStack {
                                Color.red.ignoresSafeArea()
                                
                                Text(comicBook.titleAndIssue)
                            }
                            .onTapGesture {
                                viewModel.dismisSheet()
                            }
                        }
                    }
        }
    }
}

#Preview {
    let vm = DashboardViewModel()
    vm.weeklyList = WeeklyListResponse.preview.weeklyList
    
    return NewComicsView()
        .environmentObject(vm)
}
