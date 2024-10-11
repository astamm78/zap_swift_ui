//
//  CurrentListView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct CurrentListView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading,
                spacing: 0,
                pinnedViews: .sectionHeaders
            ) {
                if let currentList = viewModel.currentList,
                   !currentList.comicBooks.isEmpty {
                    Section {
                        ForEach(currentList.comicBooks) { comicBook in
                            ComicBookCell(comicBook: comicBook)
                                .setPurchaseView()
                        }
                    } header: {
                        CurrentListHeader(title: currentList.dateString)
                    }
                }
                
                if let leftoverList = viewModel.leftoverList,
                   !leftoverList.comicBooks.isEmpty {
                    Section {
                        ForEach(leftoverList.comicBooks) { comicBook in
                            ComicBookCell(comicBook: comicBook)
                                .setPurchaseView()
                        }
                    } header: {
                        CurrentListHeader(title: "Leftovers")
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
    vm.currentList = ShoppingList.preview.shoppingList.allComicsSelected()
    vm.leftoverList = LeftoverList.preview.allComicsSelected()
    
    return CurrentListView()
        .environmentObject(vm)
}

