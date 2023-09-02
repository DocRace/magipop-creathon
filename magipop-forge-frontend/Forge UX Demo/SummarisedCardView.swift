//
//  SummarisedCardView.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/7/31.
//

import SwiftUI

struct SummarisedCardView: View {
    
    var sampleCard = sampleCards.randomElement()!
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image("avatar4")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("Race Li")
                                .font(.subheadline)
                            Text("23/08/08")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Spacer()
                
                Image("random7")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            }
            
            Text("""
Rick and Morty were in the garage working on Rick's latest invention. "Pass me the quantum carburetor Morty," said Rick. Morty handed him the strange device.
Suddenly a portal opened up and another Rick and Morty stepped out. "Hey, we're you from another dimension," said the new Rick.
""")
                .font(.body)
            

            HStack {
                Image("map")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 30)
                Spacer()
                HStack {
                    Image(systemName: "heart")
                    Text("\(Int.random(in: 30...500))")
                }
                HStack {
                    Image(systemName: "message")
                    Text("\(Int.random(in: 3...128))")
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}


struct SummarisedCardView2: View {
    var card: Card = sampleCards.randomElement()!
    let formatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "yy/MM/dd"
          return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image("avatar\(Int.random(in: 1...13))")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text(card.user)
                                .font(.subheadline)
                            Text(formatter.string(from: card.creationTime))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Spacer()
                
                // You might need to replace the image source here
                Image("random\(Int.random(in: 1...30))")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            }
            
            Text(card.text)
                .font(.body)
            

            HStack {
                Image("map")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 30)
                Spacer()
                HStack {
                    Image(systemName: "heart")
                    Text("\(Int.random(in: 30...500))")
                }
                HStack {
                    Image(systemName: "message")
                    Text("\(Int.random(in: 3...128))")
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct SummarisedCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SummarisedCardView()
            
            SummarisedCardView2(
                card: Card(
                    user: "Rick",
                    creationTime: Date(),
                    text: "In an alternate dimension, Morty and I discovered a world entirely populated by sentient pizzas. The pizzas were living in fear of being eaten by a race of giant humans. It was a cheesy nightmare, literally.",
                    title: "Pizza Nightmare Dimension",
                    isTrend: true,
                    isRandom: false,
                    isSelected: false,
                    commentCount: 15,
                    likes: 100
                )
            )
        }
    }
}


//struct SummarisedCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummarisedCardView()
//    }
//}
