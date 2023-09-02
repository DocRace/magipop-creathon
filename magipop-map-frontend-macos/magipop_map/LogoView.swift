//
//  LogoView.swift
//  magipop_map
//
//  Created by Sloan GW on 9/1/23.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack {
            BlurView(material: .fullScreenUI)
                .frame(width: 100, height: 240)
            VStack {
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 100, height: 50)
                    .overlay(
                        Text("Login")
                            .foregroundColor(.black)
                    )
                Text("Share adventure")
                    .foregroundColor(.black)
                    .padding()
                Text("Gain reputation")
                    .foregroundColor(.black)
            }
        }
    }
}

//struct BlurView: NSViewRepresentable {
//    let material: NSVisualEffectView.Material
//
//    func makeNSView(context: NSViewRepresentableContext<BlurView>) -> NSVisualEffectView {
//        let view = NSVisualEffectView()
//        view.material = material
//        view.blendingMode = .withinWindow
//        return view
//    }
//
//    func updateNSView(_ nsView: NSVisualEffectView, context: NSViewRepresentableContext<BlurView>) {}
//}

#Preview {
    LogoView()
}
