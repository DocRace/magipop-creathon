//
//  CardView.swift
//  magipop_map
//
//  Created by Sloan GW on 9/1/23.
//

import SwiftUI

struct CardView: View {
    var title: String
    var name: String
    
    var body: some View {
        ZStack {
            Image("title_" + title)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 300)
                .clipped()
            
            VStack {
                Spacer()
                ZStack {
                    BlurView(material: .fullScreenUI)
                    Text(name)
                        .foregroundColor(.black)
                }
                .frame(height: 50)
            }
        }
        .frame(width: 200, height: 300)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct BlurView: NSViewRepresentable {
    let material: NSVisualEffectView.Material

    func makeNSView(context: NSViewRepresentableContext<BlurView>) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = .withinWindow
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: NSViewRepresentableContext<BlurView>) {}
}

#Preview {
    CardView(title: "the_legend_of_zelda_breath_of_the_wild", name: "The Legend of Zelda: Breath of the Wild")
}
