//
//  Operators.swift
//  Cards
//
//  Created by Jenn Lee on 3/14/25.
//

import SwiftUI

func + (left: CGSize, right: CGSize) -> CGSize {
    CGSize(width: left.width + right.width,
           height: left.height + right.height)
}
