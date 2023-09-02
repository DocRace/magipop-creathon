//
//  NodeModel.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/8/2.
//

import Foundation

struct Node {
    let id: Int
    let name: String
    let children: [Node]?
}

let data: Node = .init(id: 1, name: "Root", children: [
    .init(id: 2, name: "Child 1", children: [
        .init(id: 3, name: "Grandchild 1", children: nil),
        .init(id: 4, name: "Grandchild 2", children: nil)
    ]),
    .init(id: 5, name: "Child 2", children: nil)
])
