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
                    colors: [leadBGGradientColor, .white],
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
    
    var leadBGGradientColor: Color {
        if comicBook.purchased {
            return .green.opacity(0.25)
        } else if comicBook.selected {
            return .zapYellow.opacity(0.25)
        } else if comicBook.followed {
            return .zapBlue.opacity(0.25)
        } else {
            return .gray.opacity(0.25)
        }
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
    comicBookPreview(ComicBook.preview, setPurchaseView: false)
}

#Preview("Shopping List View") {
    var comicBook = ComicBook.preview
    
    return comicBookPreview(comicBook)
}

#Preview("Shopping List View Purchased") {
    var comicBook = ComicBook.preview
    comicBook.purchased = true
    
    return comicBookPreview(comicBook)
}

#Preview("Shopping List View Selected") {
    var comicBook = ComicBook.preview
    comicBook.selected = true
    
    return comicBookPreview(comicBook)
}


#Preview("Shopping List View Followed") {
    var comicBook = ComicBook.preview
    comicBook.followed = true
    
    return comicBookPreview(comicBook)
}


@MainActor func comicBookPreview(_ comicBook: ComicBook, setPurchaseView: Bool = true) -> some View {
    ZStack {
        ComicBookCell(comicBook: comicBook)
            .if(setPurchaseView, transform: { view in
                view.setPurchaseView()
            })
            .environmentObject(DashboardViewModel())
    }
    .frame(height: 160)
}
