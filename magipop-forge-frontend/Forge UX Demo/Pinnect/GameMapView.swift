import SwiftUI

struct Flag: Identifiable {
    let id = UUID()
    let emoji: String
    let position: CGPoint
}

struct GameMapView: View {
    @State private var showNewFlagView = false
    @State private var newFlagPosition: CGPoint?
    @State private var selectedFlag = true
    @State private var zoomAmount: CGFloat = 1.0
    @State private var lastZoomAmount: CGFloat = 1.0
    @GestureState private var dragGestureState: CGSize = .zero
    @State private var centerPoint: CGPoint = .zero
    @State private var flags = [
        Flag(emoji: "🏳️", position: CGPoint(x: 150, y: 320)),
        Flag(emoji: "🏴‍☠️", position: CGPoint(x: 270, y: 180)),
        Flag(emoji: "🏁", position: CGPoint(x: 390, y: 450)),
        Flag(emoji: "🏳️", position: CGPoint(x: 480, y: 310)),
        Flag(emoji: "🏴", position: CGPoint(x: 560, y: 170)),
        Flag(emoji: "🏁", position: CGPoint(x: 690, y: 390)),
        Flag(emoji: "🏳️", position: CGPoint(x: 810, y: 240)),
        Flag(emoji: "🏴‍☠️", position: CGPoint(x: 930, y: 130)),
        Flag(emoji: "🏁", position: CGPoint(x: 1050, y: 420)),
        Flag(emoji: "🏳️", position: CGPoint(x: 1170, y: 350)),
        Flag(emoji: "🏴", position: CGPoint(x: 1280, y: 210)),
        Flag(emoji: "🏁", position: CGPoint(x: 1410, y: 480)),
        Flag(emoji: "🏳️", position: CGPoint(x: 1530, y: 320)),
        Flag(emoji: "🏴", position: CGPoint(x: 1670, y: 260)),
        Flag(emoji: "🏁", position: CGPoint(x: 1790, y: 430)),
        Flag(emoji: "🏳️", position: CGPoint(x: 1910, y: 360)),
        Flag(emoji: "🏴", position: CGPoint(x: 2030, y: 280)),
        Flag(emoji: "🏁", position: CGPoint(x: 2150, y: 410)),
        Flag(emoji: "🏳️", position: CGPoint(x: 2270, y: 330)),
        Flag(emoji: "🏴", position: CGPoint(x: 2390, y: 240))
    ]
    @State private var selectedChapter = "Chapter 1"
    let chapters = ["Chapter 1", "Chapter 2", "Chapter 3"]

    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    Color.black
                    Image("map-background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * zoomAmount, height: geometry.size.height * zoomAmount)
                        .offset(x: centerPoint.x + dragGestureState.width, y: centerPoint.y + dragGestureState.height)
                    
                    ForEach(flags) { flag in
                        Text(flag.emoji)
                            .font(.system(size: 50))
                            .position(x: (flag.position.x * self.zoomAmount) + centerPoint.x + dragGestureState.width,
                                      y: (flag.position.y * self.zoomAmount) + centerPoint.y + dragGestureState.height)
                            .onTapGesture {
                                selectedFlag = true
                            }
                            .sheet(isPresented: $selectedFlag) {
                                ContentCardView()
                            }
                    }
                    
                    if let position = newFlagPosition {
                        ZStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title).bold()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .position(position)
                                .onTapGesture {
                                    showNewFlagView = true // 当红色圆形被点击时，显示新视图
                                }
                                .sheet(isPresented: $showNewFlagView) {
                                    CreateView2()
                                }
                        }
                    }

                }
                .onTapGesture { location in
                    // 当用户点击地图时，如果点击的不是一个旗帜，则存储用户点击的位置
                    let flag = flags.first { flag in
                        let flagPosition = CGPoint(x: (flag.position.x * self.zoomAmount) + centerPoint.x + dragGestureState.width,
                                                   y: (flag.position.y * self.zoomAmount) + centerPoint.y + dragGestureState.height)
                        return sqrt(pow(location.x - flagPosition.x, 2) + pow(location.y - flagPosition.y, 2)) < 30
                    }
                    if flag == nil {
                        newFlagPosition = location
                    }
                }
                .clipped()
                .gesture(
                    DragGesture()
                        .onChanged { _ in
                            newFlagPosition = nil 
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let delta = value / self.lastZoomAmount
                            self.lastZoomAmount = value
                            self.zoomAmount *= delta
                        }
                        .onEnded { value in
                            self.lastZoomAmount = 1.0
                            self.centerPoint = CGPoint(x: self.centerPoint.x + self.dragGestureState.width, y: self.centerPoint.y + self.dragGestureState.height)
                        }
                )
                .simultaneousGesture(
                    DragGesture()
                        .updating($dragGestureState) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            self.centerPoint = CGPoint(x: self.centerPoint.x + value.translation.width, y: self.centerPoint.y + value.translation.height)
                        }
                )
            }
            .ignoresSafeArea(.all, edges: [.top])

            VStack {
                Spacer()
                ZStack {
                    GameBlurView(style: .dark)
                    VStack {
                        HStack {
                            Image("avatar2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 66, height: 66)
                                .clipShape(Circle())
                                .padding()
                            VStack {
                                HStack {
                                    Text("Sloan_GW").bold()
                                        .foregroundColor(Color.white)
                                    Spacer()
                                }
                                .padding(.bottom, 2)
                                HStack {
                                    Image(systemName: "person.crop.square")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 16))
                                        .frame(width: 20)
                                    Text("Role: Manager / Initiator / Creator")
                                        .foregroundColor(Color.white)
                                        .font(.caption)
                                    Spacer()
                                }.opacity(0.6)
                                HStack {
                                    Image(systemName: "flame")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 16))
                                        .frame(width: 20)

                                    Text("Reputation: 246")
                                        .foregroundColor(Color.white)
                                        .font(.caption)
                                    Spacer()
                                }.opacity(0.6)

                            }
                        }
                        
                        HStack {
                                Text("Progress")
                                    .foregroundColor(Color.white)

                                Spacer()
                                
                                Picker(selection: $selectedChapter, label: Text("Choose Chapter")) {
                                    ForEach(chapters, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                            .padding(.horizontal)
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Location")
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 2)
                                Group {
                                    Text("Shrine")
                                    Text("Cave")
                                    Text("Temple")
                                }
                                .foregroundColor(Color.white)
                                .font(.caption)
                                .opacity(0.6)
                                Spacer()
                            }
                            
                            Spacer()

                            VStack(alignment: .leading) {
                                Text("Loot")
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 2)
                                Group {
                                    Text("Weapon")
                                    Text("Armor")
                                    Text("Gem")
                                }
                                .foregroundColor(Color.white)
                                .font(.caption)
                                .opacity(0.6)
                                Spacer()
                            }
                            
                            Spacer()

                            VStack(alignment: .leading) {
                                Text("Enemie")
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 2)
                                Group {
                                    Text("Dragon")
                                    Text("Lynel")
                                }
                                .foregroundColor(Color.white)
                                .font(.caption)
                                .opacity(0.6)
                                Spacer()
                            }
                        }
                        .padding()
                        
                        ZStack {
                            Color.black
                                
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 16))
                                    .frame(width: 20)
                                Text("Search")
                                    .foregroundColor(Color.white)
                                    .font(.caption)
                                Spacer()
                            }
                            .opacity(0.6)
                            .padding()
                        }

                    }
                }
                    .frame(minWidth: 0, maxWidth: 600, idealHeight: 50, maxHeight: 320, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(.horizontal, 10)

            }
            
            
        }
    }
}

struct GameBlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
    }
}


struct GameMapView_Previews: PreviewProvider {
    static var previews: some View {
        GameMapView()
    }
}
