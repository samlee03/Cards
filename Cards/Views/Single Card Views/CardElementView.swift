//
//  CardElementView.swift
//  Cards
//
//  Created by Jenn Lee on 3/25/25.
//

import SwiftUI

struct CardElementView: View {
    let element: CardElement
    var body: some View {
        if let element = element as? ImageElement {
            ImageElementView(element: element)
                .clip()
        }
        if let element = element as? TextElement {
            TextElementView(element: element)
        }
    }
}
struct ImageElementView: View {
    let element: ImageElement
    var body: some View {
        element.image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
struct TextElementView: View {
    let element: TextElement
    var body: some View {
        if !element.text.isEmpty {
            Text(element.text)
                .font(.custom(element.textFont, size: 200))
                .foregroundColor(element.textColor)
                .scalableText()
        }
    }
}
struct CardElementView_Previews: PreviewProvider {
    static var previews: some View {
        CardElementView(element: initialElements[0])
    }
}
private extension ImageElementView {
    @ViewBuilder
    func clip() -> some View {
        if let frameIndex = element.frameIndex {
            let shape = Shapes.shapes[frameIndex]
            self
                .clipShape(shape)
                .contentShape(shape)
        } else { self }
    }
}
