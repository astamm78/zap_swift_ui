//
//  ComicBookCell.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicBookCell: View {
    @EnvironmentObject var dashboardVM: DashboardViewModel
    
    var comicBook: ComicBook
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .foregroundStyle(.gray)
                .frame(height: 0.6)
            
            HStack(alignment: .center, spacing: 12) {
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
                    Button {
                        dashboardVM.comicBookActionTapped(comicBook)
                    } label: {
                        if comicBook.selected {
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
                    .padding(.bottom, 8)
                    
                    Text(comicBook.price)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
                    Text(comicBook.titleAndIssue)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
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
            .frame(height: 160)
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
}

#Preview {
    ComicBookCell(comicBook: ComicBook.preview)
        .environmentObject(DashboardViewModel())
}
