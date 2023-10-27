

import SwiftUI
//import Solana

struct Alchemy: View {
    
    @State private var cards = magirySampleCards
    @State private var showingLinkView = false
    @State private var rotationAngle: Double = 0
    @State private var offset = CGRect.zero
    @State private var zIndex: CGFloat = 0
    @State private var isCreateModalPresented = false

    var body: some View {
        VStack {
            ZStack {
                ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
                    MagiryCardView(model: card)
                        .frame(width: 350, height: 266, alignment: .center)
                        .rotationEffect(.degrees(isFrontCard(index) ? rotationAngle : 0))
                        .offset(y: CGFloat(index * 6))
                        .offset(x: 0, y: index == cards.count - 1 ? -offset.height : 0)
                        .zIndex(index == cards.count - 1 ? zIndex : 0)
                        .animation(.default, value: offset)
                        .gesture(
                            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                .onChanged({ gesture in
                                    guard isFrontCard(index) else { return }
                                    offset = CGRect(origin: gesture.location, size: gesture.translation)
                                    rotationAngle = getRotationAgnle()
                                    if abs(offset.height) > 300 {
                                        zIndex = -1
                                    } else {
                                        zIndex = 0
                                    }
                                })
                                .onEnded({ gesture in
                                    guard isFrontCard(index) else { return }
                                    if abs(offset.height) > 300 {
                                        let width = UIScreen.main.bounds.size.width/2
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            rotationAngle = 360 * (offset.origin.x < width ? 1 : -1)
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            cards.removeLast()
                                            cards.insert(card, at: 0)
                                            zIndex = 0
                                            rotationAngle = 0
                                        }
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            offset.size.height -= 100
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                offset = .zero
                                            }
                                        }
                                    } else {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            rotationAngle = 0
                                            offset = .zero
                                        }
                                    }
                                })
                        )
                }
            }
            .padding(.bottom, 36)
            
            ScrollView {
                MagiryContentCardView()
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
            .sheet(isPresented: $showingLinkView) {
                LinkView()
            }
            
            .navigationBarItems(trailing: Button(action: {
                showingLinkView = true
            }) {
                Image(systemName: "flowchart")
            }
            )
        }
    }
    
    private func isFrontCard(_ index: Int) -> Bool {
        index == cards.count - 1
    }
    
    private func getRotationAgnle() -> Double {
        let width = UIScreen.main.bounds.size.width/2
        return Double(offset.height / 50) * (offset.origin.x < width ? 1 : -1)
    }
}

struct MagiryContentCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(magirySampleCards.randomElement()!.title)
                .font(.title).bold()
            HStack {
                Image("avatar\(Int.random(in: 1...13))")
                    .resizable()
                    .frame(width: 54, height: 54)
                    .clipShape(Circle())
                    .padding(.bottom, 8)
                VStack(alignment: .leading) {
                    Text("Race Li")
                        .font(.headline)
                    Text("08/08/2023")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Image("random\(Int.random(in: 1...30))")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding(.bottom, 8)
            
            Text("""
Rick and Morty were in the garage working on Rick's latest invention. "Pass me the quantum carburetor Morty," said Rick. Morty handed him the strange device.
Suddenly a portal opened up and another Rick and Morty stepped out. "Hey, we're you from another dimension," said the new Rick.
"Wow, I can't believe there are alternate versions of us," said Morty.
"Yeah there's infinite timelines kid, some nearly identical others completely different," explained Rick.
Just then a Cromulon alien ship appeared overhead. "Show me what you got!" it bellowed.
The two Ricks looked at each other and nodded. They pulled out laser guns and blasted the ship out of the sky before it could attack.
"Wubba lubba dub dub!" cheered the Ricks. The Mortys just stood there amazed at what they had witnessed.
""")
                .font(.body)
                .padding(.bottom, 8)
            
            Image("random\(Int.random(in: 1...30))")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding(.bottom, 8)
            
            HStack {
                Image("map")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 40)
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
        .cornerRadius(24)
        .padding()
    }
}


#Preview {
    Alchemy()
}
