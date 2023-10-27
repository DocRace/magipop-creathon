//
//  LinkView.swift
//  Magiry
//
//  Created by Race Li on 2023/10/12.
//

import SwiftUI

struct LinkView: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Text("Link Map").font(.title3).bold().padding()
            FullScreenImageZoomView(image: UIImage(named: "link")!)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct FullScreenImageZoomView: UIViewControllerRepresentable {
    var image: UIImage

    func makeUIViewController(context: Context) -> UIViewController {
        let childVC = UIViewController()
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        let imageView = UIImageView(image: image)

        imageView.contentMode = .scaleAspectFit
        imageView.frame = UIScreen.main.bounds

        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.addSubview(imageView)

        childVC.view.addSubview(scrollView)
        return childVC
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No-op
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return scrollView.subviews.first
        }

        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            guard let imageView = scrollView.subviews.first as? UIImageView else { return }
            let imageViewSize = imageView.frame.size
            let scrollViewSize = scrollView.bounds.size
            let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
            let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
            scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        }
    }
}


#Preview {
    LinkView()
}
