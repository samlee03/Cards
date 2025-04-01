//
//  CardStore.swift
//  Cards
//
//  Created by Jenn Lee on 3/25/25.
//

import SwiftUI

class CardStore: ObservableObject {
    @Published var cards: [Card] = []
    @Published var selectedElement: CardElement?
    init(defaultData: Bool = false) {
        cards = defaultData ? initialCards : load()
    }
    func index(for card: Card) -> Int? {
        cards.firstIndex { $0.id == card.id }
    }
    func remove(_ card: Card) {
        if let index = index(for: card) {
            cards.remove(at: index)
        }
    }
    func addCard() -> Card {
        let card = Card(backgroundColor: Color.random())
        cards.append(card)
        card.save()
        return card
    }
}

extension CardStore {
    func load() -> [Card] {
        var cards: [Card] = []
        let path = URL.documentsDirectory.pathExtension
        guard
            let enumerator = FileManager.default
            .enumerator(atPath: path),
            let files = enumerator.allObjects as? [String]
        else { return cards }
        let cardFiles = files.filter { $0.contains(".rwcard")}
        for cardFile in cardFiles {
            do {
                let path = path + "/" + cardFile
                let data =
                    try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let card = try decoder.decode(Card.self, from: data)
                cards.append(card)
            } catch {
                print("Error: ", error.localizedDescription)
            }
        }
        return cards
    }
}
