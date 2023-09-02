//
//  MarkLinkView.swift
//  magipop_map
//
//  Created by Sloan GW on 9/1/23.
//

import SwiftUI

struct MarkLinkView: View {
    @State private var relation: String = ""
    @State private var direction: Int = 0
    @State private var image: NSImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                            // Action for adding image
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 260, height: 180)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            HStack {
                Text("Relation")
                TextField("Relation", text: $relation)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
            }
            
            HStack {
                Text("Direction")
                Picker(selection: $direction, label: Text("")) {
                    Text("Forward").tag(0)
                    Text("Backward").tag(1)
                    Text("Two-way").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.leading)
            }
        }
        .padding()
        .frame(width: 300)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
//    class Coordinator: NSObject {
//        func selectImage() -> NSImage? {
//            let openPanel = NSOpenPanel()
//            openPanel.allowedContentTypes = [".png", ".jpg", ".jpeg"]
//            openPanel.allowsMultipleSelection = false
//            openPanel.canChooseDirectories = false
//
//            if openPanel.runModal() == .OK {
//                if let url = openPanel.url, let image = NSImage(contentsOf: url) {
//                    return image
//                }
//            }
//
//            return nil
//        }
//    }
}

#Preview {
    MarkLinkView()
}
