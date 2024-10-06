//
//  PublisherHeader.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import SwiftUI

struct PublisherHeader: View {
    var publisher: Publisher
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .foregroundStyle(.gray)
                .frame(height: 0.6)
            
            HStack(alignment: .center, spacing: 12) {
                publisher.logoImage
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(.gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45, alignment: .center)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(publisher.name)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
                    Text("\(publisher.comicBooks.count) Comic Books")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
            }
            .padding()
            .frame(height: 60)
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
    ZStack {
        Color.red
            .ignoresSafeArea()
        
        PublisherHeader(
            publisher: Publisher.preview
        )
    }
}
