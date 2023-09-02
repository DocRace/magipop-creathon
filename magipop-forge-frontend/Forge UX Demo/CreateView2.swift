//
//  CreateView2.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/8/3.
//

import SwiftUI
import UIKit

struct NoteEditorView: View {
    @Binding var text: String
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            TextEditor(text: $text)
        }
    }
}

struct ToolbarView: View {
    var onBagClick: () -> Void
    var onAlbumClick: () -> Void
    var onForgeClick: () -> Void
    
    @Binding var showingForgeView: Bool
    
    var body: some View {
        HStack {
            Button(action: onBagClick) {
                Image(systemName: "bag")
                    .font(.system(size: 22))
                    .foregroundColor(Color("control"))
                    .padding(.trailing)
            }
            Button(action: onAlbumClick) {
                Image(systemName: "photo.on.rectangle")
                    .font(.system(size: 22))
                    .foregroundColor(Color("control"))
                    .padding(.trailing)
            }
            
            Button(action: {
                self.showingForgeView.toggle()
            }) {
                HStack {
                    Spacer()
                    Text("Forge Preview").bold()
                        .padding(.leading, 20)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.system(size: 20, weight: .bold))
                }
                    .foregroundColor(Color("controlWithBackground"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("control"))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .padding(.leading)

        }
        .padding()
    }
}

struct CreateView2: View {
    @State private var text: NSAttributedString = NSAttributedString(string: "")
    @State private var selectedImage: UIImage? = UIImage(named: "placeholder")
    @State private var cursorPosition: Int = 0
    @State private var showingBagView: Bool = false
    @State private var showingImagePicker: Bool = false
    @State private var showingForgeView: Bool = false
    @State var selectedCards: [Card] = [Card(
        user: "Rick",
        creationTime: Date(),
        text: "Ever heard of a dimension where everyone communicates through burps? Yeah, didn't think so.",
        title: "Pizza Nightmare Dimension",
        isTrend: false,
        isRandom: false,
        isSelected: true,
        commentCount: 20,
        likes: 170
    )]
    @Environment(\.presentationMode) private var presentationMode
    
    // Add a default card selection and text, and load the placeholder image
    init() {
        // Default text
        let story = """
        Rick and Morty, the quirky grandfather-grandson duo, embarked on a new adventure. In an alternate dimension, they discovered a world entirely populated by sentient pizzas.

        The pizzas were living in fear of being eaten by a race of giant humans. It was a cheesy nightmare, literally.

        Rick, in his typical nonchalant manner, proposed a solution. 'Why don't we just invent a machine that makes these giant humans lactose intolerant?' he suggested.

        Morty, always the voice of reason, pointed out, 'Rick, don't you think that's just a temporary solution? Shouldn't we try to help them coexist peacefully instead?'

        Rick shrugged. 'Peaceful coexistence sounds boring. But alright, let's do it your way.'

        And so, they set off on their mission, facing monstrous cheese slicers, dodging lethal tomato sauce splashes and negotiating peace treaties with angry pepperonis. The world of sentient pizzas would never be the same again.
        """
        
        _text = State(initialValue: NSAttributedString(string: story, attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor(Color("text"))]))

        // Default card
        let defaultCard = Card(
            user: "Rick",
            creationTime: Date(),
            text: story,
            title: "Pizza Nightmare Dimension",
            isTrend: true,
            isRandom: false,
            isSelected: false,
            commentCount: 15,
            likes: 100
        )
        _selectedCards = State(initialValue: [defaultCard])

        // Default image
        if let image = UIImage(named: "placeholder") {
            _selectedImage = State(initialValue: image)
        }
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                RichTextEditor(text: $text, selectedImage: $selectedImage, cursorPosition: $cursorPosition)
                    .padding(.horizontal)
                ToolbarView(
                    onBagClick: { self.showingBagView.toggle() },
                    onAlbumClick: { self.showingImagePicker.toggle() },
                    onForgeClick: { self.showingForgeView.toggle() }, showingForgeView: $showingForgeView
                )
            }
            .navigationBarTitle("Create", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color("control"))
            })

        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
        }
        .sheet(isPresented: $showingBagView, onDismiss: addCardsToText) {
            ForgeView(sampleCards: sampleCards, selectedCards: $selectedCards)
        }
        .sheet(isPresented: $showingForgeView, onDismiss: addCardsToText) {
            ForgePreviewView()
        }
    }
    
    func addCardsToText() {
        let mutableAttributedString = NSMutableAttributedString(attributedString: text)
        
        for card in selectedCards {
            let cardView = SummarisedCardView2(card: card)
            let image = cardView.snapshot()
            let resizedImage = image.resized(toWidth: UIScreen.main.bounds.width - 40)
            let textAttachment = NSTextAttachment()
            textAttachment.image = resizedImage
            let imageString = NSAttributedString(attachment: textAttachment)
            mutableAttributedString.insert(imageString, at: cursorPosition)
            cursorPosition += 1
        }
        
        text = mutableAttributedString
        selectedCards = [] // Reset the selected cards
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        insertImage(selectedImage)
    }
    
    func insertImage(_ image: UIImage) {
        let screenWidth = UIScreen.main.bounds.width
        let resizedImage = image.resized(toWidth: screenWidth - 40) // Subtracting 40 to account for padding
        let textAttachment = NSTextAttachment()
        textAttachment.image = resizedImage
        let imageString = NSAttributedString(attachment: textAttachment)
        let mutableAttributedString = NSMutableAttributedString(attributedString: text)
        mutableAttributedString.insert(imageString, at: cursorPosition)
        text = mutableAttributedString
    }
}

struct RichTextEditor: UIViewRepresentable {
    @Binding var text: NSAttributedString
    @Binding var selectedImage: UIImage?
    @Binding var cursorPosition: Int
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        context.coordinator.textView = textView
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
        cursorPosition = context.coordinator.getCursorPosition()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: RichTextEditor
        var textView: UITextView?
        
        init(_ parent: RichTextEditor) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.attributedText
        }
        
        func getCursorPosition() -> Int {
            return textView?.selectedRange.location ?? 0
        }
    }
}

extension UIImage {
    func resized(toWidth width: CGFloat, cornerRadius: CGFloat = 5.0) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(UIBezierPath(roundedRect: CGRect(origin: .zero, size: canvasSize),
                                      cornerRadius: cornerRadius).cgPath)
        context?.clip()
        draw(in: CGRect(origin: .zero, size: canvasSize))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}


struct CreateView2_Previews: PreviewProvider {
    static var previews: some View {
        CreateView2()
    }
}
