//
//  Card.swift
//  Cards
//
//  Created by Jenn Lee on 3/25/25.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    var backgroundColor: Color = .yellow
    var elements: [CardElement] = []
    
    mutating func addElement(uiImage: UIImage) {
        let imageFilename = uiImage.save()
        let element = ImageElement(imageFilename: imageFilename, uiImage: uiImage)
        elements.append(element)
    }
    mutating func addElement(text: TextElement) {
        elements.append(text)
    }
    mutating func addElements(from transfer: [CustomTransfer]) {
        for element in transfer {
            if let text = element.text {
                addElement(text: TextElement(text: text))
            } else if let image = element.image {
                addElement(uiImage: image)
            }
        }
    }
    mutating func remove(_ element: CardElement) {
        if let element = element as? ImageElement {
            UIImage.remove(name: element.imageFilename)
        }
        if let index = element.index(in: elements) {
            elements.remove(at: index)
        }
    }
    mutating func update(_ element: CardElement?, frameIndex: Int) {
        if let element = element as? ImageElement,
           let index = element.index(in: elements) {
            var newElement = element
            newElement.frameIndex = frameIndex
            elements[index] = newElement
        }
    }
    func save() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            let filename = "\(id).rwcard"
            let url = URL.documentsDirectory
                .appendingPathComponent(filename)
            try data.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension Card:Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder
            .container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: id) ?? UUID()
        elements += try container
            .decode([ImageElement].self, forKey: .imageElements)
    }
    enum CodingKeys: CodingKey {
        case id, backgroundColor, imageElements, textElements
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.uuidString, forKey: .id)
        let imageElements: [ImageElement] =
        elements.compactMap { $0 as? ImageElement }
        try container.encode(imageElements, forKey: .imageElements)
    }
}
