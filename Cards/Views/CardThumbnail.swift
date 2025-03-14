//
//  CardThumbnail.swift
//  Cards
//
//  Created by Jenn Lee on 3/13/25.
//

import SwiftUI

struct CardThumbnail: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.random())
            .frame(width: Settings.thumbnailSize.width, height: Settings.thumbnailSize.height)
    }
}

struct CardThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        CardThumbnail()
    }
}
