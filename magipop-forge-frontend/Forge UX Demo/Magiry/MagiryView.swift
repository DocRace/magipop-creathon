//
//  ContentView.swift
//  Magiry
//
//  Created by Race Li on 2023/10/12.
//

import SwiftUI
//import Solana

struct MagiryView: View {
    @State private var showingDetail = false
    @State private var showingFiltered = false
    @State private var showingWallet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                NavigationLink(destination: Alchemy()) {
                    MagiryCreatorView()
                        .background(Color("labyrinthBackground"))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: CreathonView()) {
                    MagiryCreatorView(title: "Bubble Observers", imageName: "bubble")
                        .background(Color("bubbleBackground"))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding(.horizontal)
                        .padding(.bottom)

                }
                .buttonStyle(PlainButtonStyle())
            }
            .sheet(isPresented: $showingDetail) {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            showingDetail = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.headline)
                                .padding(.bottom)
                                .foregroundColor(Color("control"))
                        }
                        Spacer()
                    }
                    Group {
                        Text("Initiator Contract Address").bold()
                        Text("0x123456789abcdef0123456789abcdef012345678")
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text("Curator Contract Address").bold()
                        Text("0xabcdef0123456789abcdef0123456789abcdef01")
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text("Creator Contract Address").bold()
                        Text("0x789abcdef0123456789abcdef0123456789abcdef")
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text("Deployer Address").bold()
                        Text("0x3456789abcdef0123456789abcdef0123456789abcde")
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text("Contract Description").bold()
                        
                        Text("This contract oversees the process of creating, curating, and initiating projects. It allows participants to vote on decisions, contribute to the project, and earn rewards for their contributions.")
                            .font(.caption)
                    }
                    Spacer()
                }.padding(21)
            }
            .sheet(isPresented: $showingFiltered) {
                FilterView()
            }
            .sheet(isPresented: $showingWallet) {
                ConnectView()
            }

            
            .navigationBarTitle("Trending Projects")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                showingDetail = true
            }) {
                Image(systemName: "link")
            }
            )
            .navigationBarItems(trailing: Button(action: {
                showingFiltered = true
            }) {
                Image(systemName: "line.3.horizontal.decrease.circle")
            }
            )
            .navigationBarItems(leading: Button(action: {
                showingWallet = true
            }) {
                Text("Connect")
            }
            )


        }
    }
}

struct MagiryCreatorView: View {
    var title = "The labyrinth S2"
    var imageName = "labyrinth"
    let descriptionText = """
The entire book unfolds through the exploration and journey of two ghost bubbles.
The ghost bubbles come from the god "One" of a symbiotic multi-self entity from the future, who predicts that the future civilization will inevitably head towards a great collapse. Therefore, it dispatches computing sprites to simulate different possibilities in parallel universes, while also sending ghost bubbles to trace history as observers, seeking the reasons from the past.
The computing sprites calculated different universes and found that the end is still a great collapse, with only a slight difference in timing.
"The Hitchhiker's Guide" is the whole exploration process of the two ghost bubbles (ghost bubbles are units of personality that can split and merge, usually appearing in pairs, promoting the story forward as dialogues) within which one ghost bubble, influenced by human emotions and story experiences in the past human world - that is the initial era of the current Metaverse - suddenly realizes something when it sees the computer in front of the author. It decides to stay, not returning to the world of "One", but saying goodbye to it and becoming the author himself. In his sleep, it becomes a part of his subconscious and in this way, it shapes itself.
The ghost bubble realized that the so-called collapse is actually a greater fusion of life and death. It saw new life in the collapse and saw a greater significance. It realized that the collapse itself is the answer. So the bubble becomes a part of the author, writing down "The Hitchhiker's Guide", becoming the book in front of the reader.
This spiritual connotation pays tribute to "Zima Blue" from "Love, Death & Robots". Zima Blue's obsession with the blue tile is just like the ghost bubble's obsession.
The biggest loop in the framework is the larger fusion perspective of the bubble, which leads to the subsequent biological, physical, connected, and artistic universe. Then all the readers who see the bibliography, they will ultimately become the ancestors of "One". The story will not directly write whether the ghost bubble directly told One what it discovered. But the reader will tell.
Decomposition is another kind of life.
The Metaverse is a black hole, a one-way door, and "One" is nothing more than a product of the black hole.
The fusion itself must come with disintegration, otherwise, it is not a fusion. Disintegration is another perspective of fusion, it is a one-way door itself, from a larger perspective, we will definitely break this one-way door.
Each station becomes a separate book in its own right.
"""

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title).bold()
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 16)

            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(.horizontal, 12)

                GeometryReader { geometry in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width)
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .padding(.horizontal, 14)
            }
            .padding(.bottom, 8)


//            HStack {
//                Text("Co-create Mechanism")
//                    .font(.title2).bold()
//                Spacer()
//            }
//            .padding(.horizontal)

            Text(descriptionText)
                .lineLimit(6)
                .font(.system(.footnote))
                .truncationMode(.tail)
                .padding(.horizontal, 12)


            VStack(alignment: .leading) {
                                
                MagiryUsersScrollView()


                Button(action: {
                    // action here
                }) {
                    Text("Join as Creator")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 24)
                        .padding()
                        .foregroundColor(Color("controlWithBackground"))
                        .background(Color("control"))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding(.horizontal, 12)
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .cornerRadius(16)
        }
    }
}

struct MagiryUsersScrollView: View {
    let userNames = [
        "CoolTraveler78",
        "Fit_Guru2023",
        "CodeMaster_66",
        "FoodieQueen101",
        "MovieBuff99",
        "ArtLuvr808",
        "StylishDiva33",
        "MusicJunkie2023",
        "BookWorm_567",
        "GamingGeek44",
        "The_TravelAddict",
        "YogaFanatic88",
        "PizzaLover2023",
        "TechWhiz909",
        "FitLife2023",
        "TheArtiste",
        "MovieCritic101",
        "CaffeineQueen",
        "TheBookNerd",
        "GamerDude44"
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(1...5, id: \.self) { index in
                    VStack {
                        Image("avatar\(index+6)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        Text(userNames.randomElement()!)
                            .lineLimit(1)
                            .frame(width: 90)
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
        }
    }
}



#Preview {
    MagiryView()
}
