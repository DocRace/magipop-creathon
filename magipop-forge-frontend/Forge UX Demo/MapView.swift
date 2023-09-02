//
//  MapView.swift
//  magipop_map
//
//  Created by Sloan GW on 9/1/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    var title: String
    var name: String
    
    @Binding var scale: CGFloat
    @State private var offset: CGSize = .zero
    @State private var lastClickPosition: CGPoint? = nil
    @State private var isMarkViewPresented: Bool = false
        
    var body: some View {
        Image("map_"+title)
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(scale)
            .offset(offset)
            .clipped()  
            .gesture(MagnificationGesture()
                .onChanged { value in
                    self.scale = value.magnitude
                })
//            .onAppear {
//                NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
//                    self.handleKeyEvent(event)
//                    return event
//                }
//            }
        if let lastClickPosition = lastClickPosition {
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
                .position(lastClickPosition)
        }
                    
        if isMarkViewPresented {
            MarkView()
                .frame(width: 200, height: 200)
                .background(Color.white)
                .cornerRadius(20)
                .padding()
                .onTapGesture {
                    self.isMarkViewPresented = false
                }
        }
    }
    
//    func handleKeyEvent(_ event: NSEvent) {
//        switch event.charactersIgnoringModifiers {
//        case "=":
//            self.scale += 0.5
//        case "-":
//            self.scale -= 0.5
//        case "w":
//            self.offset = CGSize(width: self.offset.width, height: self.offset.height + 10)
//        case "a":
//            self.offset = CGSize(width: self.offset.width + 10, height: self.offset.height)
//        case "s":
//            self.offset = CGSize(width: self.offset.width, height: self.offset.height - 10)
//        case "d":
//            self.offset = CGSize(width: self.offset.width - 10, height: self.offset.height)
//        default:
//            break
//        }
//    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(title: "the_legend_of_zelda_breath_of_the_wild", name: "The Legend of Zelda: Breath of the Wild", scale: .constant(1))
    }
}

