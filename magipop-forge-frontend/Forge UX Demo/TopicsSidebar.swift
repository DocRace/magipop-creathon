//
//  TopicsSidebar.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/8/8.
//

import SwiftUI

struct TopicsSidebar: View {
    @State var isDrawerOpen: Bool = false
    
    var body: some View {
        ZStack {
            // Main View
            VStack {
                Text("Main View")
                Button(action: {
                    withAnimation {
                        self.isDrawerOpen.toggle()
                    }
                }) {
                    Text(self.isDrawerOpen ? "Close Drawer" : "Open Drawer")
                }
            }
            
            // Overlay Blur
            if isDrawerOpen {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            self.isDrawerOpen = false
                        }
                    }
            }
            
            // Drawer
            GeometryReader { geometry in
                HStack {
                    VStack {
                        Button(action: {
                            withAnimation {
                                self.isDrawerOpen.toggle()
                            }
                        }) {
                            Text("Close Drawer")
                        }
                        Spacer()
                        NavigationView {
                            
                            Form {
                                Section {
                                    VStack(alignment: .leading) {
                                        GeometryReader { geometry in
                                            Image("bubble")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: geometry.size.width)
                                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                                .padding(.vertical, 12)
                                            
                                        }
                                        Text("Bubble Observers").font(.title3).bold()
                                            .padding(.horizontal, 4)
                                            .padding(.bottom, 4)
                                        Text("""
    The entire book unfolds through the exploration and journey of two ghost bubbles.
    The ghost bubbles come from the god "One" of a symbiotic multi-self entity from the future, who predicts that the future civilization will inevitably head towards a great collapse. Therefore, it dispatches computing sprites to simulate different possibilities in parallel universes, while also sending ghost bubbles to trace history as observers, seeking the reasons from the past.
    """)
                                        .padding(.horizontal, 4)
                                        .padding(.bottom, 4)

                                        Spacer()

                                    }
                                }
                                
                                Section {
                                    HStack {
                                        Image(systemName: "plus.circle.fill")
                                        Text("Create new topic")
                                    }
                                    .font(.title3.bold())
                                }
                            }
                            .navigationTitle("Switch Topics")
                        }
                    }
                    .frame(width: geometry.size.width / 1.3)
                    .offset(x: self.isDrawerOpen ? 0 : -geometry.size.width / 1.3)
                    .animation(.default, value: isDrawerOpen) // Add animation when drawer opens or closes
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                        .onEnded { value in
                            if value.translation.width < -geometry.size.width * 0.2 {
                                withAnimation {
                                    self.isDrawerOpen = false
                                }
                            }
                        }
                )
            }
        }
    }
}
struct TopicsSidebar_Previews: PreviewProvider {
    static var previews: some View {
        TopicsSidebar()
    }
}
