//
//  ForgePreviewView.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/8/3.
//

import SwiftUI

struct ForgePreviewView: View {
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                HStack(alignment: .top) {
                
                  // Inner card
                  VStack {
                    
                    // Inner data
                    HStack {
                      Text("Words").font(.caption)
                      Text("1000").font(.caption).foregroundColor(.secondary)
                    }
                    
                    HStack {
                      Text("Genre").font(.caption)
                      Text("Fiction").font(.caption).foregroundColor(.secondary)
                    }
                    
                  }
                  .padding()
                  .frame(maxWidth: .infinity)
                  .frame(height: 60)
                  .background(Color(.systemGray5))
                  .cornerRadius(8)
                  
                  Spacer()
                  
                  // Outer card
                  VStack {
                    
                    // Outer data
                    Text("Related Series").font(.caption)
                    Text("Rick and Morty").font(.subheadline)
                    
                  }
                  .padding()
                  .frame(maxWidth: .infinity)
                  .frame(height: 60)
                  .background(Color(.systemGray5))
                  .cornerRadius(8)

                }
                .padding(.horizontal)

                // Scrollable placeholder
                ScrollView(.horizontal) {
                    HStack {
                        ContentCardView()
                            .frame(width: UIScreen.main.bounds.width - 5)
                        ContentCardView()
                            .frame(width: UIScreen.main.bounds.width - 5)
                        ContentCardView()
                            .frame(width: UIScreen.main.bounds.width - 5)
                    }
                }
                
                Spacer()
                
                // Post button
                Button(action: {
                    // Handle the create action here
                }) {
                    Text("Post")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .padding(.horizontal)

            }
            .navigationBarTitle("Forge Preview")
            
        }
        
    }
    
}

struct ForgePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ForgePreviewView()
    }
}
