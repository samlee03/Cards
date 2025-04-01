//
//  CardsListView.swift
//  Cards
//
//  Created by Jenn Lee on 3/13/25.
//

import SwiftUI

struct CardsListView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var store: CardStore
    @State private var selectedCard: Card?
    var body: some View {
        VStack {
            list
                .fullScreenCover(item: $selectedCard) { card in
                    if let index = store.index(for: card) {
                        SingleCardView(card: $store.cards[index])
                            .onChange(of: scenePhase) { newScenePhase in
                                if newScenePhase == .inactive {
                                    store.cards[index].save()
                                }
                            }
                    } else {
                        fatalError("Unable to locate selected card")
                    }
                    
            }
            Button("Add"){
                selectedCard = store.addCard()
            }
        }
    }
    var list: some View {
        ScrollView (showsIndicators: false) {
            VStack {
                ForEach(store.cards) { card in
                    CardThumbnail(card: card)
                        .contextMenu{
                            Button(role: .destructive){
                                store.remove(card)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .onTapGesture {
                            selectedCard = card
                        }
                }
                
            }
        }
    }
}

struct CardsListView_Previews: PreviewProvider {
    static var previews: some View {
        CardsListView()
            .environmentObject(CardStore(defaultData: true))
    }
}
