//
//  CurrentListHeader.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import SwiftUI

struct CurrentListHeader: View {
    var title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .foregroundStyle(.gray)
                .frame(height: 0.6)
            
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
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
    CurrentListHeader(title: "Wednesday, October 9, 2024")
}
