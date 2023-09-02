//
//  OverallView.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/7/31.
//

import SwiftUI

let sampleCards: [Card] = [
    Card(
        user: "Rick",
        creationTime: Date(),
        text: "In an alternate dimension, Morty and I discovered a world entirely populated by sentient pizzas. The pizzas were living in fear of being eaten by a race of giant humans. It was a cheesy nightmare, literally.",
        title: "Pizza Nightmare Dimension",
        isTrend: true,
        isRandom: false,
        isSelected: false,
        commentCount: 15,
        likes: 100
    ),
    Card(
        user: "Morty",
        creationTime: Date(),
        text: "Rick and I once traveled to a dimension where everything was drawn by a four-year-old. The laws of physics were all over the place. I still have nightmares about the scribble monsters.",
        title: "Child-drawn Dimension",
        isTrend: false,
        isRandom: true,
        isSelected: false,
        commentCount: 20,
        likes: 80
    ),
    Card(
        user: "Summer",
        creationTime: Date(),
        text: "One day, Rick gave me a device that could change the color of anything. I turned the whole world pink before I realized it wasn't a dream. Good times.",
        title: "World Changing Color Device",
        isTrend: false,
        isRandom: false,
        isSelected: true,
        commentCount: 12,
        likes: 120
    ),
    // More card instances
    Card(
        user: "Beth",
        creationTime: Date(),
        text: "The time we had Morphizer-XE... I turned into a giant monster mom. It was not my finest hour.",
        title: "Giant Monster Mom Incident",
        isTrend: true,
        isRandom: false,
        isSelected: false,
        commentCount: 18,
        likes: 150
    ),
    Card(
        user: "Jerry",
        creationTime: Date(),
        text: "Remember when I got that alien parasite stuck to my face? That sucked.",
        title: "Alien Parasite Incident",
        isTrend: false,
        isRandom: true,
        isSelected: false,
        commentCount: 22,
        likes: 70
    ),
    Card(
        user: "Rick",
        creationTime: Date(),
        text: "Ever heard of a dimension where everyone communicates through burps? Yeah, didn't think so.",
        title: "Burping Communication Dimension",
        isTrend: false,
        isRandom: false,
        isSelected: true,
        commentCount: 20,
        likes: 170
    ),
    Card(
        user: "Morty",
        creationTime: Date(),
        text: "There's this one time when Rick gave me a love potion. It escalated quickly.",
        title: "Love Potion Incident",
        isTrend: true,
        isRandom: false,
        isSelected: false,
        commentCount: 28,
        likes: 90
    ),
    Card(
        user: "Summer",
        creationTime: Date(),
        text: "I once got locked in a Mad Max style post-apocalyptic world. That was crazy.",
        title: "Post-apocalyptic World Adventure",
        isTrend: false,
        isRandom: true,
        isSelected: false,
        commentCount: 32,
        likes: 140
    ),
    // Continue creating more Card instances until there are 20 of them...
]

struct OverallView: View {
    // Sample data
    
    @Binding var isDrawerOpen: Bool
    @State private var selection = "Trend"
    @State private var isCreateModalPresented = false
        
    var filteredCards: [Card] {
        switch selection {
        case "Trend":
            return sampleCards.filter { $0.isTrend }
        case "Random":
            return sampleCards.filter { $0.isRandom }
        case "Selected":
            return sampleCards.filter { $0.isSelected }
        default:
            return sampleCards
        }
    } // Selected / Fragment / Creathon 
    
    var body: some View {
        NavigationView {
            ScrollView {
                Picker("Filter", selection: $selection) {
                    Text("Trend").tag("Trend")
                    Text("Random").tag("Random")
                    Text("Selected").tag("Selected")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 21)

                ForEach(filteredCards, id: \.text) { card in
                    NavigationLink(destination: ContentView()) {
                        SummarisedCardView2(card: card)
                            .padding(.horizontal, 21)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer(minLength: 100)
            }
            .navigationBarTitle("Forge")
            
            
            
            .navigationBarItems(leading: Button(action: {
                withAnimation {
                    isDrawerOpen.toggle()
                }
            }) {
                Image(systemName: "rectangle.stack")
            }
            )
        }
        .overlay(
            Button(action: {
                isCreateModalPresented = true
            }) {
                Text("Create")
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 24)
                    .padding()
                    .foregroundColor(Color("controlWithBackground"))
                    .background(Color("control"))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .padding(.horizontal, 21)
            .padding(.bottom, 12)
            .sheet(isPresented: $isCreateModalPresented) {
                CreateView2()
            },
            alignment: .bottom
        )
    }
}

struct OverallView_Previews: PreviewProvider {
    static var previews: some View {
        OverallView(isDrawerOpen: .constant(false))
    }
}
