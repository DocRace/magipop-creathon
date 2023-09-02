//
//  MapView2.swift
//  magipop_map
//
//  Created by Race Li on 2023/9/2.
//
import SwiftUI

struct Coordinate: Identifiable {
    let id = UUID()
    var point: CGPoint
    var isBlue: Bool
}

struct MapView2: View {
    var title: String
    var name: String
    
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var chapterSelected = "1st chapter"
    @State private var hotspotsSelected = "off"
    @State private var isShowingPopup = false
    @State private var isShowingInput = false
    @State private var popupPosition: CGPoint = .zero
    @State private var selectedLocation: CGPoint? = nil
    @State private var isShowingCharacterStoryPopup = false
    @State private var characterInput: String = ""
    @State private var storyInput: String = ""
    
    
    // Additional properties to simulate data (replace with actual data)
    let locations: [CGPoint] = [
        CGPoint(x: 100, y: 100),
        CGPoint(x: 200, y: 200),
        // Add more locations here...
    ]
    
    @State private var blueLocations: [Coordinate] = [
        Coordinate(point: CGPoint(x: 550, y: 350), isBlue: true),
        Coordinate(point: CGPoint(x: 350, y: 260), isBlue: true),
        Coordinate(point: CGPoint(x: 450, y: 250), isBlue: true),
        Coordinate(point: CGPoint(x: 420, y: 200), isBlue: true),
        Coordinate(point: CGPoint(x: 300, y: 230), isBlue: true),
        Coordinate(point: CGPoint(x: 580, y: 290), isBlue: true),
        // Add more blue locations here...
    ]
    
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
            .contentShape(Rectangle()) // Enable hit testing for sidebar
            
                
            
            MapView(title: self.title, name: self.name, scale: $scale)
                .background(Color.clear) // Remove the background gesture handling
                .frame(width: 800)
                .clipped()
                .onTapGesture {
                    popupPosition = getCursorPosition()
                    isShowingInput.toggle()
                }
                .overlay(
                    Group { // Group to conditionally show the popup
                        ForEach($blueLocations) { $location in // Use binding here
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 20, height: 20)
                                .position(getScaledPosition(location.point))
                                .onTapGesture {
                                    if location.isBlue {
                                        popupPosition = location.point
                                        isShowingPopup.toggle()
                                    }
                                }
                        }
                        
                        if isShowingPopup {
                            popupContent()
                                .position(popupPosition)
                        }
                        if isShowingInput{
                            inputContent()
                                .position(popupPosition)
                            
                        }
                        
                    }
                )
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
                        Text("Popularity")
                        Text("Status")
                        Text("Identity")
                        Text("Manage")
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
                    Text("Progress")
                    Menu(chapterSelected) {
                        Button("1st chapter", action: { chapterSelected = "1st chapter" })
                        // Add more chapters here...
                    }
                }
                HStack {
                    Text("show popularity")
                    Menu(hotspotsSelected) {
                        Button("on", action: { hotspotsSelected = "on" })
                        Button("off", action: { hotspotsSelected = "off" })
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
                Text("location")
                // Add location list here...
                Text("NPC")
                // Add NPC list here...
                Text("monster")
                // Add monster list here...
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
    }
    
    // Function to display the popup content
    func popupContent() -> some View {
        ScrollView {
            Text("Date Created: June 1, 2023") // Replace with actual creation date
            Text("Created By: John Doe") // Replace with actual creator
            
            ContentCardView()
                
            
        }
        .frame(width: 300, height: 300)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    func inputContent() -> some View {
        VStack {
            TextField("Enter Story", text: $storyInput)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            TextField("Enter Character", text: $characterInput)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            CreateView2()
            Button("Submit") {
                // Handle the submission of story and character inputs
                isShowingInput.toggle()
            }

        }
        .padding()
        .frame(width: 500, height: 800)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        
    }
    
    private func getScaledPosition(_ point: CGPoint) -> CGPoint {
        // 获取地图的中心点
        let mapCenter = CGPoint(x: 400, y: 700) // 可以根据你的地图大小进行调整

        // 计算蓝点相对于地图中心的位置
        let relativePosition = CGPoint(x: point.x - mapCenter.x, y: point.y - mapCenter.y)

        // 缩放蓝点相对于地图中心的位置，然后加上地图中心的位置
        let scaledRelativePosition = CGPoint(x: relativePosition.x * scale, y: relativePosition.y * scale)
        let scaledPosition = CGPoint(x: mapCenter.x + scaledRelativePosition.x + offset.width, y: mapCenter.y + scaledRelativePosition.y + offset.height)

        return scaledPosition
    }
    
    private func getCursorPosition() -> CGPoint {
        // Replace with logic to get the cursor position
        // For example, you can use the current mouse position or touch location
        // and convert it to the coordinate space of the map view
        return CGPoint(x: 300, y: 400) // Example position
    }
}

struct MapView2_Previews: PreviewProvider {
    static var previews: some View {
        MapView2(title: "the_legend_of_zelda_breath_of_the_wild", name: "The Legend of Zelda: Breath of the Wild")
    }
}
