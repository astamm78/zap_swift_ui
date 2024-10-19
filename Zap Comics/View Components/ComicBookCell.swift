//
//  ComicBookCell.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import SwiftUI
import SDWebImageSwiftUI

class ComicBookCellViewModel: ObservableObject {
    @Published var isPurchaseView: Bool = false
    @Published var isPastListView: Bool = false
}

struct ComicBookCell: View {
    @EnvironmentObject var dashboardVM: DashboardViewModel
    
    @ObservedObject var viewModel = ComicBookCellViewModel()
    @ObservedObject var comicBook: ComicBook
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .foregroundStyle(.gray)
                .frame(height: 0.6)
            
            HStack(alignment: .top, spacing: 12) {
                WebImage(url: comicBook.imageURL)
                    .resizable()
                    .frame(width: 90, height: 135)
                    .aspectRatio(contentMode: .fit)
                    .shadow(
                        color: .black.opacity(0.24),
                        radius: 6,
                        x: 0,
                        y: 2
                    )
                
                VStack(alignment: .leading, spacing: 8) {
                    if viewModel.isPastListView {
                        Text(comicBook.purchased ? "Purchased" : "Unpurchased")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    } else {
                        HStack(alignment: .center, spacing: 8) {
                            if viewModel.isPurchaseView {
                                Button {
                                    dashboardVM.markComicBookPurchased(comicBook)
                                } label: {
                                    ResizableImage(
                                        name: "icon-purchase",
                                        height: 20,
                                        width: 20,
                                        contentMode: .fit,
                                        templateRenderingMode: .template,
                                        imageColor: comicBook.purchased ? .green : .gray
                                    )
                                }
                            }
                            
                            Button {
                                dashboardVM.comicBookActionTapped(comicBook, isPurchaseView: viewModel.isPurchaseView)
                            } label: {
                                if comicBook.selected || viewModel.isPurchaseView {
                                    ResizableImage(
                                        name: "icon-remove_comic",
                                        height: 20,
                                        width: 20,
                                        contentMode: .fit,
                                        templateRenderingMode: .template,
                                        imageColor: .gray
                                    )
                                } else {
                                    ResizableImage(
                                        name: "icon-add_comic",
                                        height: 20,
                                        width: 20,
                                        contentMode: .fit,
                                        templateRenderingMode: .template,
                                        imageColor: .zapBlue
                                    )
                                }
                            }
                        }
                        .padding(.bottom, 8)
                    }
                    
                    Text(comicBook.price)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
                    Text(comicBook.titleAndIssue)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    comicBook.shoppingList.map { shoppingList in
                        Text(shoppingList.dateString)
                            .fontWeight(.bold)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    Button {
                        dashboardVM.select(comicBook)
                    } label: {
                        Text("View More")
                            .font(.footnote)
                            .foregroundStyle(.zapBlue)
                    }

                }
                
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [.gray.opacity(0.25), .white],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
            )
            
            Rectangle()
                .foregroundStyle(.gray)
                .frame(height: 0.6)
        }
        .background(.white)
    }
    
    func setPurchaseView() -> Self {
        viewModel.isPurchaseView = true
        return self
    }
    
    func setPastListView() -> Self {
        viewModel.isPastListView = true
        return self
    }
}

#Preview {
    ComicBookCell(comicBook: ComicBook.preview)
        .environmentObject(DashboardViewModel())
}

#Preview("Shopping List View") {
    var comicBook = ComicBook.preview
    
    return ComicBookCell(comicBook: comicBook)
        .setPurchaseView()
        .environmentObject(DashboardViewModel())
}

#Preview("Shopping List View Purchased") {
    var comicBook = ComicBook.preview
    
    return ComicBookCell(comicBook: comicBook)
        .setPurchaseView()
        .environmentObject(DashboardViewModel())
}
