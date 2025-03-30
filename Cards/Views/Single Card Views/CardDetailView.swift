//
//  CardDetailView.swift
//  Cards
//
//  Created by Jenn Lee on 3/25/25.
//

import SwiftUI

struct CardDetailView: View {
    @EnvironmentObject var store: CardStore
    @Binding var card: Card
    
    func isSelected(_ element: CardElement) -> Bool {
        store.selectedElement?.id == element.id
    }
    var body: some View {
        ZStack {
            card.backgroundColor
                .onTapGesture {
                    store.selectedElement = nil
                }
            ForEach($card.elements, id: \.id) { $element in
                
                
                CardElementView(element: element)
                    .overlay(
                        element: element,
                        isSelected: isSelected(element))
                    
                    .elementContextMenu(
                        card: $card,
                        element: $element)
                    .resizableView(transform: $element.transform)
                    .frame(
                        width: element.transform.size.width,
                        height: element.transform.size.height
                    )
                    .onTapGesture {
                        store.selectedElement = element
                    }
            }
        }
        .onDisappear {
            store.selectedElement = nil
        }
    
        .dropDestination(for: CustomTransfer.self) { items, location in
            print(location)
            Task {
                card.addElements(from: items)
            }
            return !items.isEmpty
        }
        
    }
}

private extension View {
    @ViewBuilder
    func overlay(
        element: CardElement,
        isSelected: Bool
    ) -> some View {
        if isSelected,
           let element = element as? ImageElement,
           let frameIndex = element.frameIndex {
            let shape = Shapes.shapes[frameIndex]
            self.overlay(shape
                .stroke(lineWidth: Settings.borderWidth)
                .foregroundStyle(Settings.borderColor))
            
        } else {
            self
                .border(
                    Settings.borderColor,
                    width: isSelected ? Settings.borderWidth : 0)
        }
    }
}
    
    struct CardDetailView_Previews: PreviewProvider {
        struct CardDetailPreview: View {
            @EnvironmentObject var store: CardStore
            var body: some View {
                CardDetailView(card: $store.cards[0])
            }
        }
        static var previews: some View {
            CardDetailView(card: .constant(initialCards[0]))
                .environmentObject(CardStore(defaultData: true))
        }
    }
    
//    #Preview {
//        @Previewable @State var card = initialCards[0]
//        CardDetailView(card: $card)
//            .environmentObject(CardStore(defaultData: true))
//    }
