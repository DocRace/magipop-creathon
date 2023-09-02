//
//  MarkView.swift
//  magipop_map
//
//  Created by Sloan GW on 9/1/23.
//

import SwiftUI

struct MarkView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var tag1: Int = 0
    @State private var tag2: Int = 0
    @State private var positionX: String = ""
    @State private var positionY: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                Button(action: {
//                    self.isMarkViewPresented = false
                }) {
                    Text("Close")
                }
            }
            Button(action: {
                // Action for adding image
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 80)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            HStack {
                Text("Title")
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
            }
            
            HStack {
                Text("Description")
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
            }
            
            HStack {
                Text("Tag")
                Picker(selection: $tag1, label: Text("")) {
                    Text("Loot").tag(0)
                    Text("Quest").tag(1)
                    Text("Location").tag(2)
                }
                .pickerStyle(MenuPickerStyle())
                Picker(selection: $tag2, label: Text("")) {
                    Text("Armor").tag(0)
                    Text("Weapon").tag(1)
                    Text("Gem").tag(2)
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            HStack {
                Text("Position")
                TextField("X", text: $positionX)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Y", text: $positionY)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding()
        .frame(width: 300)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

#Preview {
    MarkView()
}
