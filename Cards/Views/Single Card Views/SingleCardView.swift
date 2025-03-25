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
            CardDetailView(card: $card)
                .modifier(CardToolbar(currentModal: $currentModal, card: $card))
                
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
