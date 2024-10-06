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
                viewModel.currentList.map { currentList in
                    Section {
                        ForEach(currentList.comicBooks) { comicBook in
                            ComicBookCell(comicBook: comicBook)
                        }
                    } header: {
                        CurrentListHeader(title: currentList.dateString)
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
    vm.currentList = ShoppingList.preview.shoppingList
    
    return CurrentListView()
        .environmentObject(vm)
}

