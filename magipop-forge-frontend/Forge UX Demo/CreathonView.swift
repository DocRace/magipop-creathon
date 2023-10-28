//
//  CreathonView.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/8/7.
//

import SwiftUI
import WebKit

struct CreathonView: View {
    @State private var showingDetail = false
    @State private var showingSettingsView = false
    @State private var selection = "Season2"

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
    let scheduleData = [
        ScheduleData(
            title: "World-building Workshop",
            status: .finished,
            description: "Join our experienced sci-fi authors as they guide you through the process of creating unique and immersive worlds for your stories."
        ),
        ScheduleData(
            title: "Alien Character Design Challenge",
            status: .finished,
            description: "Put your creativity to the test with this timed challenge to design the most intriguing alien characters. Share and discuss your creations with fellow creators."
        ),
        ScheduleData(
            title: "Futuristic Technology Brainstorming Session",
            status: .happening,
            description: "Collaborate with fellow creators to envision and discuss futuristic technologies that will shape the stories and worlds in your sci-fi series."
        ),
        ScheduleData(
            title: "Crafting Compelling Sci-fi Plots",
            status: .planning,
            description: "Learn how to develop engaging and thought-provoking storylines for your sci-fi series, with tips from successful science fiction authors."
        ),
        ScheduleData(
            title: "Virtual Reality Meet & Greet",
            status: .planning,
            description: "Don your VR headset and meet fellow creators in a virtual environment inspired by some of the greatest sci-fi worlds. Exchange ideas and network with like-minded individuals."
        )
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Picker("Filter", selection: $selection) {
                        Text("Season 2 Full Swing").tag("Season2")
                        Text("Season 1 Archive").tag("Season1")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 21)
                    
                    if selection == "Season1" {
                        WebView(url: URL(string: "https://bubble.observer/reader")!)
                            .frame(minHeight: 700)
                    } else {
                    
                        
                        Text("Bubble Observers Season 2")
                            .font(.title).bold()
                            .padding(.horizontal, 21)
                            .padding(.bottom, 2)

                        Text(descriptionText)
                            .lineLimit(7)
                            .font(.body)
                            .truncationMode(.tail)
                            .padding(.horizontal, 21)

                        Button(action: {
                            showingDetail = true
                        }) {
                            Text("Detail").bold()
                                .foregroundColor(.accentColor)
                        }
                        .sheet(isPresented: $showingDetail) {
                            VStack {
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
                                
                                ScrollView {
                                    Text(descriptionText)
                                    Spacer()
                                }
                            }
                            .padding(21)
                        }
                        .padding(.horizontal, 21)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(1...3, id: \.self) { num in
                                    Image("creathon\(num)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 200, height: 200)
                                        .cornerRadius(15)
                                }
                            }
                            .padding(.horizontal, 21)
                            .padding(.top, 8)
                            .padding(.bottom, 24)

                        }

                        Text("Schedules")
                            .font(.title2).bold()
                            .padding(.horizontal, 21)

                        ForEach(scheduleData, id: \.title) { data in
                            ScheduleCard(data: data)
                                .padding(.horizontal, 21)
                        }
                        Spacer(minLength: 80)
                    }
                }
                .sheet(isPresented: $showingSettingsView) {
                    VStack(alignment: .leading) {
                        HStack {
                            Button(action: {
                                showingSettingsView = false
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
            }
            .navigationTitle("Creathon")
            .navigationBarItems(trailing: Button(action: {
                showingSettingsView = true
            }) {
                Image(systemName: "gearshape")
            }
            )
            .overlay(
                NavigationLink(destination: JoinCreathonView(), label: {
                    if selection == "Season2" {
                        Text("Join Creathon")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 24)
                            .padding()
                            .foregroundColor(Color("controlWithBackground"))
                            .background(Color("control"))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                })
                .padding(.horizontal, 21)
                .padding(.bottom, 12),
                alignment: .bottom
            )
        }
        
    }
}

struct ScheduleData {
    let title: String
    let status: EventStatus
    let description: String
}

enum EventStatus: String {
    case finished = "Finished"
    case happening = "Now happening"
    case planning = "Planning"
}

struct ScheduleCard: View {
    var data: ScheduleData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top){
                    Text(data.title)
                        .font(.headline)
                        .foregroundColor(data.status == .finished ? .gray : (data.status == .happening ? .black : .primary))
                        .padding(.bottom)
                    Spacer()
                    Text(data.status.rawValue)
                        .font(.subheadline)
                        .foregroundColor(data.status == .finished ? .gray : (data.status == .happening ? .black : .primary))
                }
                Text(data.description)
                    .font(.body)
                    .foregroundColor(data.status == .finished ? .gray : (data.status == .happening ? .black : .primary))
            }
            .padding()
            
            Spacer()
        }
        .background(
            Color(
                uiColor: data.status == .happening ? UIColor(hex: "72FF7A") :
                data.status == .planning ? UIColor.systemGray5 : UIColor.systemGray6
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct WebView: UIViewRepresentable {

  let url: URL

  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    let request = URLRequest(url: url)
    webView.load(request)
  }

}


extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            alpha: 1
        )
    }
}

struct CreathonView_Previews: PreviewProvider {
    static var previews: some View {
        CreathonView()
    }
}
