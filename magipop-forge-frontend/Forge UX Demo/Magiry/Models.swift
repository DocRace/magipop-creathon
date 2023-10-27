//
//  Models.swift
//  CardStackAnimation
//
//  Created by Pratik on 19/11/22.
//

import SwiftUI

struct CardModel: Identifiable {
    let id = UUID()
    let color: Color
    let user: String
    let creationTime: Date
    let text: String
    let title: String
    let isTrend: Bool
    let isRandom: Bool
    let isSelected: Bool
    let rootCount: Int
    let quoteCount: Int
}
