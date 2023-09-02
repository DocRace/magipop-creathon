//
//  ContentView.swift
//  magipop_map
//
//  Created by Sloan GW on 9/1/23.
//

import SwiftUI

struct ContentView: View {
    let cards = [
        ["title": "the_legend_of_zelda_breath_of_the_wild", "name": "The Legend of Zelda: Breath of the Wild"],
        ["title": "red_dead_redemption_2", "name": "Red Dead Redemption 2"],
        ["title": "the_elder_scrolls_V", "name": "The Elder Scrolls V: Skyrim"],
        ["title": "super_mario_odyssey", "name": "Super Mario Odyssey"],
        ["title": "pokemon", "name": "Pokémon Sword Shield"],
        ["title": "animal_crossing", "name": "Animal Crossing"],
        ["title": "super_smash_bros", "name": "Super Smash Bros"]
    ]
    
    var body: some View {
        NavigationView {
            HStack {
                VStack{
                    LogoView()
                    
                    Spacer()
                    
                    
                }
                
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3)) {
                        ForEach(cards, id: \.self) { card in
                            NavigationLink(destination: MapView(title: card["title"]!, name: card["name"]!)) {
                                CardView(title: card["title"]!, name: card["name"]!)
                                    .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding()
                }
                .frame(minWidth: 800)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
