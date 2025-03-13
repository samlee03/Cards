//
//  ToolbarSelection.swift
//  Cards
//
//  Created by Jenn Lee on 3/13/25.
//

import Foundation

enum ToolbarSelection: CaseIterable, Identifiable {
    var id: Int {
        hashValue
    }
    case photoModal, frameModal, stickerModal, textModal
}
