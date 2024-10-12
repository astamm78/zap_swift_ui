//
//  LoadingAnimation.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/12/24.
//

import Foundation
import UIKit
import SwiftUI

struct LoadingAnimation: UIViewRepresentable {
    typealias UIViewType = UIImageView

    func makeUIView(context: Context) -> UIViewType {
        let animationView = UIImageView()
        animationView.animationImages = [UIImage]()

        for index in 0 ..< 24 {
            let frameName = String(format: "loader_%02d", index)
            animationView.animationImages?.append(UIImage(named: frameName)!)
        }

        animationView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        animationView.center = CGPoint(
            x: UIScreen.main.bounds.size.width / 2,
            y: UIScreen.main.bounds.size.height / 2 - 40
        )
        animationView.animationDuration = 1

        return animationView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.startAnimating()
    }
}
