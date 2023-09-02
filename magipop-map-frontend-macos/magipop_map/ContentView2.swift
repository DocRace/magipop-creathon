//
//  ContentView2.swift
//  magipop_map
//
//  Created by Race Li on 2023/9/2.
//

import SwiftUI

struct ContentView2: View {
    @State private var selectedOption: String? = "Login"
    
    let options = ["Login", "Share Adventures", "Gain Reputation"]
    let cards = [
        ["title": "the_legend_of_zelda_breath_of_the_wild", "name": "The Legend of Zelda: Breath of the Wild"],
        ["title": "red_dead_redemption_2", "name": "Red Dead Redemption 2"],
        ["title": "the_elder_scrolls_V", "name": "The Elder Scrolls V: Skyrim"],
        ["title": "super_mario_odyssey", "name": "Super Mario Odyssey"],
        ["title": "pokemon", "name": "Pokémon Sword Shield"],
        ["title": "animal_crossing", "name": "Animal Crossing"],
        ["title": "super_smash_bros", "name": "Super Smash Bros"]
        // Add your other cards here
    ]
    
    var body: some View {
        NavigationView {
            List(options, id: \.self) { option in
                NavigationLink(destination: optionContent(option),
                               tag: option, selection: $selectedOption) {
                    Text(option)
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Options")
            
            if let selectedOption = selectedOption {
                optionContent(selectedOption)
            }
        }
    }
    
    @ViewBuilder
    func optionContent(_ option: String) -> some View {
        switch option {
        case "Login":
            ScrollView {
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 4)) {
                    ForEach(cards, id: \.self) { card in
                        CardView(title: card["title"]!, name: card["name"]!)
                            .onTapGesture {
                                self.openMapView(title: card["title"]!, name: card["name"]!)
                            }
                    }
                }
                .padding()
            }
            .frame(minWidth: 800)
        // Add cases for "Share Adventures" and "Gain Reputation" here
        default:
            Text("Content for \(option)")
        }
    }
    
    func openMapView(title: String, name: String) {
        let mapWindowController = MapWindowController(title: title, name: name)
        mapWindowController.showWindow(nil)
    }
}

#Preview {
    ContentView2()
}


class MapWindowController: NSWindowController {
    convenience init(title: String, name: String) {
        let mapView = MapView2(title: title, name: name)
        let hostingController = NSHostingController(rootView: mapView)
        let window = NSWindow(contentViewController: hostingController)
        self.init(window: window)
    }
}
