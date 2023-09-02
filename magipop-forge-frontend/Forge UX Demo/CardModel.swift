//
//  CardModel.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/7/31.
//

import Foundation

// Card model
struct Card: Identifiable {
    let id = UUID()
    let user: String
    let creationTime: Date
    let text: String
    let title: String
    let isTrend: Bool
    let isRandom: Bool
    let isSelected: Bool
    let commentCount: Int
    let likes: Int
}

