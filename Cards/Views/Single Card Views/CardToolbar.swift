//
//  CardToolbar.swift
//  Cards
//
//  Created by Jenn Lee on 3/25/25.
//

import SwiftUI

struct CardToolbar: ViewModifier {
    @Environment(\.dismiss) var dismiss
    @Binding var currentModal: ToolbarSelection?
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    BottomToolbar(modal: $currentModal)
                }
            
            }
            .sheet(item: $currentModal) { item in
                switch item {
                default:
                    Text(String(describing: item))
                }
            }
    }
}

