//
//  DotBackground.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/14/24.
//

import SwiftUI

struct DotBackground: View {
    var body: some View {
        VStack {
            Spacer()

            Image("dot-pattern")
                .resizable()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.width * 0.625
                )
        }
        .ignoresSafeArea()
        .opacity(0.825)
    }
}

#Preview {
    ZStack {
        Color.zapYellow
            .ignoresSafeArea()
        
        DotBackground()
    }
}
