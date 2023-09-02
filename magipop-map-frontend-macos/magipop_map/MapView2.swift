//
//  MapView2.swift
//  magipop_map
//
//  Created by Race Li on 2023/9/2.
//
import SwiftUI

struct MapView2: View {
    var title: String
    var name: String
    
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var chapterSelected = "第一章"
    @State private var hotspotsSelected = "关"
    
    var body: some View {
        HStack {
            VStack {
                ProfileCard()
                ProgressCard(chapterSelected: $chapterSelected, hotspotsSelected: $hotspotsSelected)
                SearchCard()
                Spacer()
            }
            .padding()
            .frame(width: 250)
            
            MapView(title: self.title, name: self.name)
        }
    }
}

struct ProfileCard: View {
    var body: some View {
        VStack {
            HStack {
                Image("Avatar")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("声望")
                    Text("999")
                    Text("身份")
                    Text("管理")
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.bottom)
    }
}

struct ProgressCard: View {
    @Binding var chapterSelected: String
    @Binding var hotspotsSelected: String

    var body: some View {
        VStack {
            HStack {
                Text("进度")
                Menu(chapterSelected) {
                    Button("第一章", action: { chapterSelected = "第一章" })
                    // Add more chapters here...
                }
            }
            HStack {
                Text("显示热度")
                Menu(hotspotsSelected) {
                    Button("开", action: { hotspotsSelected = "开" })
                    Button("关", action: { hotspotsSelected = "关" })
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.bottom)
    }
}

struct SearchCard: View {
    @State private var searchText = ""

    var body: some View {
        VStack {
            TextField("Search...", text: $searchText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            Text("地点")
            // Add location list here...
            Text("NPC")
            // Add NPC list here...
            Text("怪物")
            // Add monster list here...
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    MapView2(title: "the_legend_of_zelda_breath_of_the_wild", name: "The Legend of Zelda: Breath of the Wild")
}


