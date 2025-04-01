//
//  CardsApp.swift
//  Cards
//
//  Created by Jenn Lee on 3/13/25.
//

import SwiftUI

@main
struct CardsApp: App {
    @StateObject var store = CardStore(defaultData: false)
    var body: some Scene {
        WindowGroup {
            CardsListView()
                .environmentObject(store)
                .onAppear {
                    print(URL.documentsDirectory)
                }
        }
    }

}
