//
//  JoinCreathonView.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/8/7.
//

import SwiftUI

struct JoinCreathonView: View {
    @State private var showingConnectView = false
    @State private var showingInfoView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                // Initiator Section
                Group {
                    Text("Initiator")
                        .font(.title2).bold()
                        .padding(.horizontal, 21)
                    
                    Text("The Initiator is the visionary, the one who kick-starts a project or an idea. In terms of token voting, Initiators often have the right to propose new ideas or changes that will be voted on by the community. They may have a significant number of initial tokens, enabling them to have a larger voting power. For profit sharing, the Initiator usually receives a proportion of the profit generated from the project, recognizing their role in bringing the concept to life. In terms of earnings, Initiators may benefit from the increase in value of the project's tokens as more people join and contribute to the project.")
                        .font(.body)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 21)
                    
                    UsersScrollView()
                    
                    Button(action: {
                        showingConnectView = true
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
                            .padding(.bottom, 24)
                    }
                }
                
                
                
                // Curator Section
                Group {
                    Text("Curator")
                        .font(.title2).bold()
                        .padding(.horizontal, 21)
                    
                    Text("The Curator is the gatekeeper, ensuring the quality and relevance of content within the project. They may have the power to vote on what content gets included or excluded, or which ideas align with the project's goals. While they may not have as many initial tokens as the Initiator, they can earn tokens by actively curating and maintaining the project. For profit sharing, Curators often receive a share of the profits commensurate with their ongoing contribution to the project. They can also earn from the appreciation of their tokens if the project becomes more valuable over time.")
                        .font(.body)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 21)
                    
                    UsersScrollView()
                    
                    Button(action: {
                        showingConnectView = true
                    }) {
                        Text("Join Curator")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 24)
                            .padding()
                            .foregroundColor(Color("controlWithBackground"))
                            .background(Color("control"))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .padding(.horizontal, 21)
                            .padding(.bottom, 24)
                        
                    }
                }
                
                // Creator Section
                Group {
                    Text("Creator")
                        .font(.title2).bold()
                        .padding(.horizontal, 21)
                    
                    Text("The Creator is the contributor, the one who brings skills, knowledge, and creativity to the project. Creators are often rewarded with tokens for their contributions, which they can use to vote on decisions within the project. The number of tokens they hold can increase as they contribute more to the project. In terms of profit sharing, Creators usually receive a portion of the profits based on their contributions, which could be content creation, problem-solving, or other forms of active participation. Their earnings can also come from the increase in value of their tokens if the project is successful.")
                        .font(.body)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 21)
                    
                    UsersScrollView()
                    
                    Button(action: {
                        showingConnectView = true
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
                            .padding(.bottom, 24)
                    }
                }
            }
            .sheet(isPresented: $showingConnectView) {
                ConnectView()
            }
            .sheet(isPresented: $showingInfoView) {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            showingInfoView = false
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
        .navigationTitle("Join")
        .navigationBarItems(trailing: Button(action: {
            showingInfoView = true
        }) {
            Image(systemName: "info.circle")
        }
        )
    }
}

struct UsersScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(1...5, id: \.self) { index in
                    VStack {
                        Image("avatar\(index)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Text("User \(index)")
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal, 21)
            .padding(.bottom, 8)
        }
    }
}

struct JoinCreathonView_Previews: PreviewProvider {
    static var previews: some View {
        JoinCreathonView()
    }
}
