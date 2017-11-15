//
//  ImageEditorInputTextView.swift
//  Gefen
//
//  Created by Shachar Udi on 11/13/17.
//  Copyright © 2017 Gefen. All rights reserved.
//

import UIKit
import QuartzCore

class ImageEditorInputTextView: UITextView {
    
    private let settings: ImageEditorCustomSettings
    
    init(settings: ImageEditorCustomSettings) {
        self.settings = settings
        super.init(frame: .zero, textContainer: nil)
        self.setupTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Private
    
    private func setupTextView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = settings.textFieldCornerRadius()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = settings.textViewBorederColor().cgColor
    }
}
