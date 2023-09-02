//
//  NodeView.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/8/2.
//

import SwiftUI

struct NodeView: View {
    let data: Node = .init(id: 0, name: "Root", children: [
        .init(id: 1, name: "Child 1", children: [
            .init(id: 3, name: "Grandchild 1", children: nil),
            .init(id: 4, name: "Grandchild 2", children: nil)
        ]),
        .init(id: 2, name: "Child 2", children: [
            .init(id: 5, name: "Grandchild 3", children: nil),
            .init(id: 6, name: "Grandchild 4", children: nil)
        ])
    ])
    
    var body: some View {
        GeometryReader { geometry in
            DrawNode(node: data, depth: 0, width: geometry.size.width)
        }
    }
}

struct DrawNode: View {
    let node: Node
    let depth: Int
    let width: CGFloat
    var isHighlighted: Bool {
        node.id == 3
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(isHighlighted ? Color.red : Color.blue)
                    .frame(width: 40, height: 40)
                Text(node.name)
                    .foregroundColor(.white)
            }
            HStack(spacing: 0) {
                if let children = node.children, children.count > 0 {
                    DrawNode(node: children[0], depth: depth + 1, width: width / 2)
                    DrawNode(node: children[1], depth: depth + 1, width: width / 2)
                }
            }.frame(width: width)
        }.coordinateSpace(name: "cs\(depth)")
            .background(NodeConnector().stroke(lineWidth: 1))
    }
}

struct NodeConnector: Shape {
    func path(in rect: CGRect) -> Path {
        let midX = rect.midX
        let maxY = rect.maxY
        var path = Path()
        path.move(to: CGPoint(x: midX, y: 0))
        path.addLine(to: CGPoint(x: midX, y: maxY))
        return path
    }
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        NodeView()
    }
}
