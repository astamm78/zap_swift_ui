//
//  ZapContainer.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct ZapContainer<Content: View>: View {
    @ViewBuilder var content: Content
    
    var backgroundColor: Color = Color.zapYellow
    var alignment: Alignment = .center
    
    var body: some View {
        ZStack(alignment: alignment) {
            backgroundColor
                .ignoresSafeArea()
            
            LinearGradient(
                colors: [.zapYellow, .white],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .opacity(0.45)
            
            DotBackground()
            
            content
        }
    }
}

#Preview {
    ZapContainer {
        Text("Howdy")
    }
}
