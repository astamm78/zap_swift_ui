//
//  LoadableView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/12/24.
//

import SwiftUI

struct LoadableView<Content: View>: View {
    @ViewBuilder let content: Content

    var loadingComplete: Bool

    var body: some View {
        if loadingComplete {
            content
        } else {
            loadingView
        }
    }

    var loadingView: some View {
        let width = UIScreen.main.bounds.width * 0.325

        return ZapContainer {
            Color.clear.ignoresSafeArea()

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

            LoadingAnimation()
                .frame(
                    width: width,
                    height: width,
                    alignment: .center
                )
        }
    }
}

#Preview("Unloaded") {
    LoadableView(content: {
        Text("Loaded")
    }, loadingComplete: false)
}
