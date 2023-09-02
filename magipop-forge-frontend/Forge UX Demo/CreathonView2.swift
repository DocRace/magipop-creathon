//
//  CreathonView2.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/8/14.
//

import SwiftUI

struct CreathonView2: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("creathonbackground1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea(edges: .vertical)
                
                ScrollView {
                    Spacer(minLength: 90)
                    VStack {
                        HStack(alignment: .top, spacing: 0) {
                            SchemeView()
                            CreatorView()
                        }
                        .padding(.vertical)
                        SeasonView()
                            .padding(.vertical)

                        Products()
                            .padding(.vertical)

                    }
                    
                }
                .navigationTitle("Graphics Card Speaker")
            }
        }
    }
}

struct Products: View {
    var body: some View {
        VStack {
            HStack {
                Text("Collections")
                    .font(.title).bold()
                Spacer()
            }
            .padding(.horizontal, 21)


            VStack(alignment: .leading) {
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(3...8, id: \.self) { num in
                            Image("speaker\(num)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 200)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal, 21)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(5...8, id: \.self) { num in
                            Image("speaker\(num)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 200)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal, 21)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(1...8, id: \.self) { num in
                            Image("speaker\(num)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 200)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal, 21)
                }

                
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(BlurView())
            .cornerRadius(16)
            .padding(.horizontal, 21)
            .padding(.bottom, 21)
        }

    }
}

struct SeasonView: View {
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
        VStack {
            HStack {
                Text("Creathon Season 1")
                    .font(.title).bold()
                Spacer()
            }
            .padding(.horizontal, 21)


            VStack(alignment: .leading) {
                
                
                HStack {
                    Text("Expected Production")
                        .font(.title2).bold()
                    Spacer()
                }
                .padding(.horizontal, 21)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(1...8, id: \.self) { num in
                            Image("speaker\(num)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 200)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal, 21)
                    .padding(.bottom, 24)

                }
                
                Text(descriptionText)
                    .lineLimit(3)
                    .font(.body)
                    .truncationMode(.tail)
                    .padding(.horizontal, 21)
                    .padding(.bottom, 20)

                
                HStack {
                    Text("Schedules")
                        .font(.title2).bold()
                    Spacer()
                }
                .padding(.horizontal, 21)
                .padding(.bottom, 2)

                ForEach(scheduleData, id: \.title) { data in
                    ScheduleCard(data: data)
                        .padding(.horizontal, 21)
                }

                Button(action: {
                    // action here
                }) {
                    Text("Support Creathon")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 24)
                        .padding()
                        .foregroundColor(Color("controlWithBackground"))
                        .background(Color("control"))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .padding(.horizontal, 21)
                }


                
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(BlurView())
            .cornerRadius(16)
            .padding(.horizontal, 21)
            .padding(.bottom, 12)
        }
    }
}


struct CreatorView: View {
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
                Text("Creator")
                    .font(.title).bold()
                Spacer()
            }
            .padding(.horizontal, 21)


            VStack(alignment: .leading) {
                                
                UsersScrollView()
                    .padding(.top, 12)
                UsersScrollView()
                    .padding(.bottom, 12)

                
                HStack {
                    Text("Co-create Mechanism")
                        .font(.title2).bold()
                    Spacer()
                }
                .padding(.horizontal, 21)
                .padding(.bottom, 2)

                Text(descriptionText)
                    .lineLimit(3)
                    .font(.body)
                    .truncationMode(.tail)
                    .padding(.horizontal, 21)
                    .padding(.bottom, 20)

                Button(action: {
                    // action here
                }) {
                    Text("Join Creator")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 24)
                        .padding()
                        .foregroundColor(Color("controlWithBackground"))
                        .background(Color("control"))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .padding(.horizontal, 21)
                        .padding(.bottom, 8)
                }

                Button(action: {
                    // action here
                }) {
                    Text("Publish Work")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 24)
                        .padding()
                        .foregroundColor(Color("text"))
                        .background(BlurView2())
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .padding(.horizontal, 21)
                        .padding(.bottom, 8)
                }

                
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(BlurView())
            .cornerRadius(16)
            .padding(.horizontal, 21)
            .padding(.bottom, 21)
        }
    }
}


struct SchemeView: View {
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
                Text("Scheme Info")
                    .font(.title).bold()
                Spacer()
            }
            .padding(.horizontal, 21)


            VStack(alignment: .leading) {
                
                Text(descriptionText)
                    .lineLimit(5)
                    .font(.body)
                    .truncationMode(.tail)
                    .padding(.horizontal, 21)
                    .padding(.bottom, 20)
                
                HStack {
                    Text("Share Holder")
                        .font(.title2).bold()
                    Spacer()
                }
                .padding(.horizontal, 21)

                UsersScrollView()
                    .padding(.bottom, 12)

                
                HStack {
                    Text("Decision-Making Mechanism")
                        .font(.title2).bold()
                    Spacer()
                }
                .padding(.horizontal, 21)
                .padding(.bottom, 2)

                Text(descriptionText)
                    .lineLimit(5)
                    .font(.body)
                    .truncationMode(.tail)
                    .padding(.horizontal, 21)
                    .padding(.bottom, 20)

                Button(action: {
                    // action here
                }) {
                    Text("Join Initiator")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 24)
                        .padding()
                        .foregroundColor(Color("controlWithBackground"))
                        .background(Color("control"))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .padding(.horizontal, 21)
                        .padding(.bottom, 8)
                }


                
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(BlurView())
            .cornerRadius(16)
            .padding(.horizontal, 21)
            .padding(.bottom, 21)
        }
    }
}

struct BlurView2: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemThickMaterial

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}


struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemThinMaterial

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct CreathonView2_Previews: PreviewProvider {
    static var previews: some View {
        CreathonView2()
    }
}
