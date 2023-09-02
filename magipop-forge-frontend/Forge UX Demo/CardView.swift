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
            Image("title_\(title)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 300)
                .clipped()
            
            VStack {
                Spacer()
                ZStack {
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "the_legend_of_zelda_breath_of_the_wild", name: "The Legend of Zelda: Breath of the Wild")
    }
}

