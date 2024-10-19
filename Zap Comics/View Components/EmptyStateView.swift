//
//  EmptyStateView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/14/24.
//

import SwiftUI

struct EmptyStateView<Content: View>: View {
    @ViewBuilder let content: Content
    
    var message: String

    var dataPresent: Bool

    var body: some View {
        if dataPresent {
            content
        } else {
            emptyState
        }
    }
    
    var emptyState: some View {
        ZapContainer(content: {
            Image("zap-logo")
                .grayscale(1.0)
                .opacity(0.075)
            
            HStack {
                Text(message)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .shadow(color: .white, radius: 2, x: 1, y: 3)
            }
            .padding(30)
        },
            backgroundColor: .gray
        )
        .grayscale(1.0)
    }
}

#Preview {
    EmptyStateView(
        content: {
            Text("Load some damn data")
        },
        message: "You haven't added anything from this week's list yet.",
        dataPresent: false
    )
}
