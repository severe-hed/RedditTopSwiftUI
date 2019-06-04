//
//  WrappedUIImageView.swift
//  RedditTop
//
//  Created by Sergey Khliustin on 6/4/19.
//  Copyright © 2019 Sergey Khliustin. All rights reserved.
//

import SwiftUI

final class WrappedUIImageView : UIViewRepresentable {
    typealias UIViewType = UIImageView
    lazy var imageView: UIImageView = UIImageView()
    private let url: URL
    init(url: URL) {
        self.url = url
        imageView.contentMode = .scaleAspectFit
        imageView.loadFromURL(url)
    }
    
    func makeUIView(context: UIViewRepresentableContext<WrappedUIImageView>) -> UIImageView {
        return self.imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: UIViewRepresentableContext<WrappedUIImageView>) {
    }
}
