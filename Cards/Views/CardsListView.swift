//
//  CardsListView.swift
//  Cards
//
//  Created by Jenn Lee on 3/13/25.
//

import SwiftUI

struct CardsListView: View {
    @State private var isPresented = false
    var body: some View {
        list
        .fullScreenCover(isPresented: $isPresented) {
            SingleCardView()
        }
    }
    var list: some View {
        ScrollView (showsIndicators: false) {
            VStack {
                ForEach(0..<10) { _ in
                    CardThumbnail()
                        .onTapGesture {
                            isPresented = true
                        }
                }
            }
        }
    }
}

struct CardsListView_Previews: PreviewProvider {
    static var previews: some View {
        CardsListView()
    }
}
