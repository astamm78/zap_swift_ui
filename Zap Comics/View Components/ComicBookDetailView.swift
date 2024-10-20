//
//  ComicBookDetailView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/19/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicBookDetailView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    
    var comicBook: ComicBook
    
    var body: some View {
        ZapContainer(content: {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Button {
                            viewModel.dismisSheet()
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.zapBlue)
                        }

                        Spacer()
                    }
                    
                    Text(comicBook.titleAndIssue)
                        .font(.title2)
                    
                    comicBook.creators.map { creators in
                        Text(creators)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Text(comicBook.price)
                        .font(.title)
                        .fontWeight(.ultraLight)
                    
                    comicBook.description.map { description in
                        ScrollView {
                            Text(description)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14.0, weight: .regular, design: .default))
                                .fontWeight(.light)
                        }
                    }
                    
                    comicBook.imageURL.map { imageURL in
                        VStack(alignment: .center) {
                            WebImage(url: imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 380)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding()
        }, alignment: .top)
    }
}

#Preview {
    ComicBookDetailView(comicBook: ComicBook.preview)
        .environmentObject(DashboardViewModel())
}
