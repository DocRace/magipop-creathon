//
//  ContentView.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/7/30.
//

import SwiftUI
import Combine

struct IndexedRect: Equatable {
    let index: Int
    let rect: CGRect
}

struct ContentView: View {
    @State private var target: CGRect = .zero
    @State private var rects: [IndexedRect] = Array(repeating: IndexedRect(index: 0, rect: .zero), count: 10)
    @State private var scrollViewOffset: CGFloat = .zero
    
    var body: some View {
        ScrollView {
            ZStack {
                ConnectingLines(target: self.target, rects: self.rects.map { $0.rect })
                
                VStack {
                    ContentCardView()
                        .background(GeometryReader { proxy in
                            Color.clear.preference(key: ViewOffsetKey.self, value: [IndexedRect(index: 0, rect: proxy.frame(in: .local))])
                        })
                    CustomScrollView(offsetChanged: { offset in
                        self.scrollViewOffset = offset.x
                    }) {
                        HStack(spacing: 20) {
                            ForEach(0..<10) { index in
                                SummarisedCardView()
                                    .frame(width: 300, height: 200)
                                    .background(GeometryReader { proxy in
                                        Color.clear.preference(key: ViewOffsetKey.self, value: [IndexedRect(index: index+1, rect: proxy.frame(in: .named("ScrollView")).offsetBy(dx: -self.scrollViewOffset, dy: 0))])
                                    })
                            }
                        }
                        .padding()
                    }
                }
            }
            .onPreferenceChange(ViewOffsetKey.self) { values in
                for value in values {
                    if value.index == 0 {
                        self.target = value.rect
                    } else {
                        self.rects[value.index-1] = value
                    }
                }
            }
            .coordinateSpace(name: "ScrollView")
            
            Spacer(minLength: 100)

//            Button(action: {
//                // Handle the create action here
//            }) {
//                Text("Create")
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.black)
//                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
//            }
//            .padding(.horizontal)

        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomScrollView<Content>: View where Content: View {
    let offsetChanged: (CGPoint) -> Void
    let content: Content
    
    init(offsetChanged: @escaping (CGPoint) -> Void, @ViewBuilder content: () -> Content) {
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            content
                .background(GeometryReader { proxy in
                    Color.clear.onAppear {
                        self.offsetChanged(proxy.frame(in: .global).origin)
                    }
                })
        }
    }
}


struct ContentCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(sampleCards.randomElement()!.title)
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
        .cornerRadius(10)
        .padding()
    }
}

struct RelatedCardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Related Content")
                .font(.headline)
            Text("More about Rick and Morty...")
                .font(.body)
        }
        .frame(width: 200)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct ConnectingLines: View {
    var target: CGRect
    var rects: [CGRect]
    
    var body: some View {
        ForEach(rects.indices, id: \.self) { index in
            if rects[index] != .zero {
                Path { path in
                    let startPoint = CGPoint(x: target.midX, y: target.maxY-18)
                    let endPoint = CGPoint(x: rects[index].midX, y: rects[index].minY+10)
                    path.move(to: startPoint)
                    path.addLine(to: endPoint)
                }
                .stroke(Color(red: 230 / 255, green: 232 / 255, blue: 236 / 255), lineWidth: max(5 - CGFloat(index), 0.5))
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = [IndexedRect]
    static var defaultValue = [IndexedRect]()
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
