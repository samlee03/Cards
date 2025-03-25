//
//  Card.swift
//  Cards
//
//  Created by Jenn Lee on 3/25/25.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var backgroundColor: Color = .yellow
    var elements: [CardElement] = []
}
