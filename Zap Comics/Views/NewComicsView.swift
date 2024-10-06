//
//  NewComicsView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct NewComicsView: View {
    @ObservedObject var viewModel = NewComicsViewModel()
    
    var body: some View {
        List {
            viewModel.weeklyList.map { weeklyList in
                ForEach(weeklyList.publishers) { publisher in
                    Section {
                        if viewModel.selectedPublisher == publisher {
                            ForEach(publisher.comicBooks) { comicBook in
                                Text(comicBook.title)
                                    .onTapGesture {
                                        viewModel.select(comicBook)
                                    }
                            }
                        }
                    } header: {
                        Text(publisher.name)
                            .onTapGesture {
                                viewModel.select(publisher)
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

#Preview {
    NewComicsView(
        viewModel: NewComicsViewModel()
    )
}
