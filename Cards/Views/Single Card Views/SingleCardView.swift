//
//  SingleCardView.swift
//  Cards
//
//  Created by Jenn Lee on 3/13/25.
//

import SwiftUI

struct SingleCardView: View {
    @Binding var card: Card
    @Environment(\.dismiss) var dismiss
    @State private var currentModal: ToolbarSelection?
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                CardDetailView(card: $card, viewScale: Settings.calculateScale(proxy.size))
                    .modifier(CardToolbar(currentModal: $currentModal, card: $card))
                    .onDisappear {
                        card.save()
                
                    }
                    .frame(
                        width: Settings.calculateSize(proxy.size).width,
                        height: Settings.calculateSize(proxy.size).height)
                    .scaleEffect(0.8)
                
            }
        }
    }
    var content: some View {
        card.backgroundColor
    }

}

struct SingleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardView(card: .constant(initialCards[0]))
    }
}
