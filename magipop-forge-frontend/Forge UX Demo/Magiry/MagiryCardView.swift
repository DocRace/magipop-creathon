

import SwiftUI

struct MagiryCardView: View {
    let model: CardModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(LinearGradient(colors: [model.color.opacity(0.6), model.color.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 30, style: .continuous)
//                        .stroke(lineWidth: 10)
//                        .foregroundColor(model.color.opacity(0.2))
//                )
                .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            
        
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(model.title)
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                        Spacer(minLength: 0)
                        
                        Text(model.text)
                            .lineLimit(6)
                            .font(.system(.footnote))
                            .truncationMode(.tail)
                            .foregroundColor(.black)
                    }
                    
                    
                    Spacer(minLength: 4)
                    
                    Image("random\(Int.random(in: 1...30))")
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                
                Spacer(minLength: 12)

                
                HStack {
                    Image("avatar\(Int.random(in: 1...13))")
                        .resizable()
                        .frame(width: 36, height: 36, alignment: .center)
                        .clipShape(Circle())

                    Text(model.user)
                        .lineLimit(1)
                        .font(.system(.footnote))
                        .truncationMode(.tail).bold()
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text("Roots: \(model.rootCount)")
                        .lineLimit(1)
                        .font(.system(.footnote))
                        .truncationMode(.tail).bold()
                        .foregroundColor(.black)
                        .padding(.trailing, 8)
                                        
                    Text("\(model.quoteCount) quoted")
                        .lineLimit(1)
                        .font(.system(.footnote)).bold()
                        .truncationMode(.tail)
                        .foregroundColor(.black)


                }
                
            }     
            .padding()

        }
    }
}

let magirySampleCards: [CardModel] = [
    CardModel(
        color: .purple,
        user: "Rick",
        creationTime: Date(),
        text: "In an alternate dimension, Morty and I discovered a world entirely populated by sentient pizzas. The pizzas were living in fear of being eaten by a race of giant humans. It was a cheesy nightmare, literally.",
        title: "Pizza Nightmare Dimension",
        isTrend: true,
        isRandom: false,
        isSelected: false,
        rootCount: 15,
        quoteCount: 100
    ),
    CardModel(
        color: .blue,
        user: "Morty",
        creationTime: Date(),
        text: "Rick and I once traveled to a dimension where everything was drawn by a four-year-old. The laws of physics were all over the place. I still have nightmares about the scribble monsters.",
        title: "Child-drawn Dimension",
        isTrend: false,
        isRandom: true,
        isSelected: false,
        rootCount: 20,
        quoteCount: 80
    ),
    CardModel(
        color: .yellow,
        user: "Summer",
        creationTime: Date(),
        text: "One day, Rick gave me a device that could change the color of anything. I turned the whole world pink before I realized it wasn't a dream. Good times.",
        title: "World Changing Color Device",
        isTrend: false,
        isRandom: false,
        isSelected: true,
        rootCount: 12,
        quoteCount: 120
    ),
    // More card instances
    CardModel(
        color: .cyan,
        user: "Beth",
        creationTime: Date(),
        text: "The time we had Morphizer-XE... I turned into a giant monster mom. It was not my finest hour.",
        title: "Giant Monster Mom Incident",
        isTrend: true,
        isRandom: false,
        isSelected: false,
        rootCount: 18,
        quoteCount: 150
    ),
    CardModel(
        color: .purple,
        user: "Jerry",
        creationTime: Date(),
        text: "Remember when I got that alien parasite stuck to my face? That sucked.",
        title: "Alien Parasite Incident",
        isTrend: false,
        isRandom: true,
        isSelected: false,
        rootCount: 22,
        quoteCount: 70
    ),
    CardModel(
        color: .teal,
        user: "Rick",
        creationTime: Date(),
        text: "Ever heard of a dimension where everyone communicates through burps? Yeah, didn't think so.",
        title: "Burping Communication Dimension",
        isTrend: false,
        isRandom: false,
        isSelected: true,
        rootCount: 20,
        quoteCount: 170
    ),
    CardModel(
        color: .indigo,
        user: "Morty",
        creationTime: Date(),
        text: "There's this one time when Rick gave me a love potion. It escalated quickly.",
        title: "Love Potion Incident",
        isTrend: true,
        isRandom: false,
        isSelected: false,
        rootCount: 28,
        quoteCount: 90
    ),
    CardModel(
        color: .mint,
        user: "Summer",
        creationTime: Date(),
        text: "I once got locked in a Mad Max style post-apocalyptic world. That was crazy.",
        title: "Post-apocalyptic World Adventure",
        isTrend: false,
        isRandom: true,
        isSelected: false,
        rootCount: 32,
        quoteCount: 140
    )
]


struct MagiryCardView_Previews: PreviewProvider {
    static var previews: some View {
        MagiryCardView(model: magirySampleCards.randomElement()!)
            .frame(width: 350, height: 250, alignment: .center)
    }
}
