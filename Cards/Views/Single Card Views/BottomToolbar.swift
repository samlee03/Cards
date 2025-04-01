//
//  BottomToolbar.swift
//  Cards
//
//  Created by Jenn Lee on 3/13/25.
//

import SwiftUI

struct ToolbarButton: View {
    let modal: ToolbarSelection
    private let modalButton: [
        ToolbarSelection: (text: String, imageName: String)
    ] = [
        .photoModal: ("Photos", "photo"),
        .frameModal: ("Frames", "square.on.circle"),
        .stickerModal: ("Stickers", "heart.circle"),
        .textModal: ("Text", "textformat")
    ]
    var body: some View {
        if let text = modalButton[modal]?.text,
           let imageName = modalButton[modal]?.imageName {
            
            VStack {
                Image(systemName: imageName)
                    .font(.largeTitle)
                Text(text)
            }
            .padding(.top)
        }
    }
}

struct BottomToolbar: View {
    @EnvironmentObject var store: CardStore
    @Binding var card: Card
    @Binding var modal: ToolbarSelection?
    func defaultButton(_ selection: ToolbarSelection) -> some View {
        Button{
            modal = selection
        } label: {
            ToolbarButton(modal: selection)
        }
    }
    var body: some View {
        HStack (alignment: .bottom){
            ForEach(ToolbarSelection.allCases) { selection in
                switch selection {
                case .photoModal:
                    Button {} label: {
                        PhotosModal(card: $card)
                    }
                case .frameModal:
                    defaultButton(selection)
                        .disabled(
                            store.selectedElement == nil || !(store.selectedElement is ImageElement))
                default:
                    defaultButton(selection)
                }
            }
            
        }
    }
}

struct BottomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbar(card: .constant(Card()), modal: .constant(.stickerModal))
            .padding()
            .environmentObject(CardStore())
    }
}
