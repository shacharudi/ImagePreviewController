//
//  ImageEditorVC.swift
//  Gefen
//
//  Created by Shachar Udi on 11/8/17.
//  Copyright © 2017 Gefen. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageEditorViewControllerDelegate {
    func didSelectImage(image: UIImage, text: String)
    func didCancelImageSelection()
}

public class ImageEditorViewController: UIViewController, ImageEditorTextViewDelegate {
    
    var delegate: ImageEditorViewControllerDelegate?
    internal let textInputView: ImageEditorTextView
    internal let editorImageView: ImageEditorImageView
    internal let image: UIImage
    internal var settings = ImageEditorCustomSettings()
    
    init(image: UIImage) {
        self.image = image
        self.textInputView = ImageEditorTextView(settings: self.settings)
        self.editorImageView = ImageEditorImageView(settings: self.settings)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        self.setupPhotoEditor()
        self.setupInputView()
        self.addDismissTapHandler()
    }

    //MARK:- Setting up views
    
    private func setupPhotoEditor() {
        self.view.addSubview(self.editorImageView)
        self.editorImageView.pinToSuperviewEdges()
        self.editorImageView.configure(image: self.image)
    }

    private func setupInputView() {
        self.view.addSubview(self.textInputView)
        let bottomY = settings.screenHeight() - ImageEditorTextView.defaultHeight
        textInputView.frame = CGRect(x: 0, y: bottomY, width: settings.screenWidth(), height: ImageEditorTextView.defaultHeight)
        textInputView.delegate = self
        textInputView.configure()
    }
    
    private func addDismissTapHandler() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedView))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }

    @objc private func didTappedView() {
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //registering for keyboard events on viewDidAppear prevents issue with 'keyboardWillShow' then 'keyboardWillHide' being called
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChanged(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK:- ImageEditorTextViewDelegate
    
    func didPressCancel() {
        self.textInputView.closeKeyboard()

        if let isDelegate = self.delegate {
            isDelegate.didCancelImageSelection()
        }
        else {
            ImagePreviewLogger.log(message: "ImageEditorVC has no delegate!")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func didPressSend(text: String?) {
        self.textInputView.closeKeyboard()

        guard let isImage = self.editorImageView.editedImage else { print("ImageEditorVC editedImage is Nil!");return }
        if let isDelegate = self.delegate {
            isDelegate.didSelectImage(image: isImage, text: text ?? "")
        }
        else {
            ImagePreviewLogger.log(message: "ImageEditorVC has no delegate!")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
