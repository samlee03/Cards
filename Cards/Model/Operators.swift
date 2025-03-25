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

func * (left: CGSize, right: CGFloat) -> CGSize {
    CGSize(width: left.width * right, height: left.height * right)
}

func *= (left: inout CGSize, right: Double) {
    left = CGSize (width: left.width * right, height: left.height * right)
}

func / (left: CGSize, right: CGFloat) -> CGSize {
    CGSize (width: left.width / right, height: left.height / right)
}
