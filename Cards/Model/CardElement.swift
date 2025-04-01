//
//  CardElement.swift
//  Cards
//
//  Created by Jenn Lee on 3/25/25.
//

import SwiftUI

protocol CardElement {
    var id: UUID { get }
    var transform: Transform { get set }
}

extension CardElement {
    func index(in array: [CardElement]) -> Int? {
        array.firstIndex { $0.id == id }
    }
}

struct ImageElement: CardElement {
    var imageFilename: String?
    let id = UUID()
    var transform = Transform()
    var uiImage: UIImage?
    var image: Image {
        Image(
            uiImage: uiImage ??
                UIImage(named: "error-image") ??
                UIImage())
    }
    var frameIndex: Int?
    
}
extension ImageElement: Codable {
    enum CodingKeys: CodingKey {
        case transform, imageFilename, frameIndex
    }
    init(from decoder: Decoder) throws {
        let container = try decoder
            .container(keyedBy: CodingKeys.self)
        transform = try container
            .decode(Transform.self, forKey: .transform)
        frameIndex = try container
            .decodeIfPresent(Int.self, forKey: .frameIndex)
        imageFilename = try container.decodeIfPresent(
            String.self,
            forKey: .imageFilename)
        if let imageFilename {
            uiImage = UIImage.load(uuidString: imageFilename)
        } else {
//            uiImage = UIImage.error
        }
    }
}
struct TextElement: CardElement {
    let id = UUID()
    var transform = Transform()
    var text = ""
    var textColor = Color.black
    var textFont = "Gill Sans"
}


