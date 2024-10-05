//
//  ResizableImage.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct ResizableImage: View {
    var name: String
    var height: CGFloat
    var width: CGFloat
    var contentMode: ContentMode

    var templateRenderingMode: Image.TemplateRenderingMode = .original
    var imageColor: Color = .white

    var body: some View {
        Image(name)
            .resizable()
            .renderingMode(templateRenderingMode)
            .foregroundColor(imageColor)
            .aspectRatio(contentMode: contentMode)
            .frame(width: height, height: width, alignment: .center)
            .clipped()
    }
}

struct ResizableImage_Previews: PreviewProvider {
    static var previews: some View {
        ResizableImage(
            name: "zap-logo",
            height: 88,
            width: 88,
            contentMode: .fit
        )
    }
}
