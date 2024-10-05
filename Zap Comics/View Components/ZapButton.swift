//
//  ZapButton.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct ZapButton: View {
    var action: (() -> Void)?
    var label: String
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack {
                VStack {
                    Text(label)
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 58)
            .background(Color.zapBlue)
            .cornerRadius(16)
        }

    }
}

#Preview {
    VStack {
        ZapButton(label: "Submit!")
    }
    .padding()
}
