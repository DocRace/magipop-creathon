//
//  CreateView.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/7/31.
//

import SwiftUI

import SwiftUI

struct CreateView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var bodyText = ""
    @State private var image: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var isForgeViewPresented = false
    @State private var selectedCards: [Card] = []
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .font(.title)
                    .padding(.horizontal)
                
                TextEditor(text: $bodyText)
                    .font(.body)
                    .padding(.horizontal)
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                
                HStack {
                    Button(action: {
                        sourceType = .photoLibrary
                        isImagePickerPresented = true
                    }) {
                        Image(systemName: "photo.on.rectangle").font(.title2).foregroundColor(.black)
                    }
                    
                    Button(action: {
                        sourceType = .camera
                        isImagePickerPresented = true
                    }) {
                        Image(systemName: "camera").font(.title2).foregroundColor(.black)
                    }
                }.padding()
                
                Button(action: {
                    isForgeViewPresented = true
                }) {
                    Text("Forge")
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.groupTableViewBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(selectedCards, id: \.text) { card in
                            SummarisedCardView2(card: card)
                                .frame(width: 300, height: 200)
                                .padding(.horizontal)
                        }
                    }
                }
                .frame(height: 200)
                
                Button(action: {
                    //
                }) {
                    HStack {
                        Spacer()
                        Text("Next").bold()
                            .padding(.leading, 20)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20, weight: .bold))
                    }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .padding(.horizontal)
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(sourceType: sourceType, selectedImage: $image)
            }
            .sheet(isPresented: $isForgeViewPresented) {
                ForgeView(sampleCards: sampleCards, selectedCards: $selectedCards)
            }
            .navigationBarTitle("Create", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            })
            
            
        }
    }
}

struct ForgeView: View {
    let sampleCards: [Card]
    @Binding var selectedCards: [Card]
    @State private var selectedCardIndices: Set<Int> = Set()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(Array(sampleCards.enumerated()), id: \.element.id) { index, card in
                    MultipleSelectionRow(card: card, isSelected: selectedCardIndices.contains(index)) {
                        if selectedCardIndices.contains(index) {
                            selectedCardIndices.remove(index)
                        } else {
                            selectedCardIndices.insert(index)
                        }
                    }
                }
            }
            .navigationBarTitle("Forge", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                selectedCards = Array(selectedCardIndices).map { sampleCards[$0] }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
            })
        }
    }
}

struct MultipleSelectionRow: View {
    var card: Card
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                SummarisedCardView2(card: card)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
