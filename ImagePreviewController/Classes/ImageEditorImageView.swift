//
//  ImageEditorImageView.swift
//  Gefen
//
//  Created by Shachar Udi on 11/12/17.
//  Copyright © 2017 Gefen. All rights reserved.
//

import UIKit

class ImageEditorImageView: UIView {
    
    public var editedImage: UIImage? {
        get { return self.imageView.image }
    }
    
    private let imageView = UIImageView(frame: .zero)
    private var originalImage: UIImage?
    private var settings: ImageEditorCustomSettings
    
    init(settings: ImageEditorCustomSettings) {
        self.settings = settings
        super.init(frame: .zero)
        self.backgroundColor = settings.IEBackgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(image: UIImage) {
        self.originalImage = image
        self.setupImageView()
    }
    
    public func setEditingMode() {
        self.animateEditingMode()
    }
    
    public func setPreviewMode() {
        self.animatePreviewMode()
    }
    
    //MARK:- Private
    
    private func setupImageView() {
        self.addSubview(self.imageView)
        self.imageView.pinToSuperviewEdges()
        self.imageView.image = self.originalImage
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = settings.imageViewBackgroundColor()
    }
    
    //MARK:- Animations

    private func animateEditingMode() {
        self.imageView.layer.opacity = 0.65
        self.imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }
    
    private func animatePreviewMode() {
        self.imageView.layer.opacity = 1.0
        self.imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }
}
