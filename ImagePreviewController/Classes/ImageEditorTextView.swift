//
//  ImageEditorTextView.swift
//  Gefen
//
//  Created by Shachar Udi on 11/13/17.
//  Copyright © 2017 Gefen. All rights reserved.
//

import UIKit

protocol ImageEditorTextViewDelegate {
    func didPressSend(text: String?)
    func didPressCancel()
}

class ImageEditorTextView: UIView {

    public static let defaultHeight: CGFloat = 44.0
    
    internal let settings: ImageEditorCustomSettings
    private let KMaxAmountOfLines: Int = 5
    private let buttonSize = CGSize(width: 44, height: 44)
    internal let imageEditorInputTextView: ImageEditorInputTextView
    private let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    private let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    
    var delegate: ImageEditorTextViewDelegate?
    
    init(settings: ImageEditorCustomSettings) {
        self.imageEditorInputTextView = ImageEditorInputTextView(settings: settings)
        self.settings = settings
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        self.setupInputView()
        self.setupComponents()
        self.addButtonHandlers()
    }
    
    public func closeKeyboard() {
        self.endEditing(true)
    }
    
    //MARK:- Private
    
    private func setupInputView() {
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        self.addSubview(self.imageEditorInputTextView)
        imageEditorInputTextView.font = self.settings.textViewFont()
        imageEditorInputTextView.delegate = self
        self.setPlaceholderText()
    }

    private func setupComponents() {
        self.backgroundColor = UIColor(white: 0.95, alpha: 1)

        leftButton.setImage(settings.cancelButtonImage(), for: .normal)
        rightButton.setImage(settings.sendButtonImage(), for: .normal)
        rightButton.tintColor = settings.sendButtonTintColor()
        
        let seperator = UIView(frame: .zero)
        seperator.backgroundColor = settings.seperatorColor()
        self.addSubview(seperator)
        
        seperator.pinToSuperviewEdge(edge: .left, toEdge: .left)
        seperator.pinToSuperviewEdge(edge: .top, toEdge: .top)
        seperator.pinToSuperviewEdge(edge: .right, toEdge: .right)
        seperator.setAutoLayoutDimention(dimention: .height, value: 1.0)
        
        leftButton.pinToSuperviewEdge(edge: .left, toEdge: .left)
        leftButton.pinToSuperviewEdge(edge: .top, toEdge: .top)
        leftButton.setAutoLayoutDimention(dimention: .width, value: buttonSize.width)
        leftButton.setAutoLayoutDimention(dimention: .height, value: buttonSize.height)
        
        rightButton.pinToSuperviewEdge(edge: .right, toEdge: .right)
        rightButton.pinToSuperviewEdge(edge: .top, toEdge: .top)
        rightButton.setAutoLayoutDimention(dimention: .width, value: buttonSize.width)
        rightButton.setAutoLayoutDimention(dimention: .height, value: buttonSize.height)

        imageEditorInputTextView.pinToViewEdge(edge: .left, toEdge: .right, ofView: leftButton)
        imageEditorInputTextView.pinToViewEdge(edge: .top, toEdge: .bottom, ofView: seperator, margin: settings.textViewPaddingInContainer())
        imageEditorInputTextView.pinToViewEdge(edge: .right, toEdge: .left, ofView: rightButton)
        imageEditorInputTextView.pinToViewEdge(edge: .bottom, toEdge: .bottom, ofView: self, margin: -settings.textViewPaddingInContainer())
    }
    
    //MARK:- Actions

    private func addButtonHandlers() {
        rightButton.addTarget(self, action: #selector(sendButtonPressed), for: UIControlEvents.touchUpInside)
        leftButton.addTarget(self, action: #selector(cancelButtonPressed), for: UIControlEvents.touchUpInside)
    }
    
    @objc func sendButtonPressed() {
        let text = (self.imageEditorInputTextView.text == settings.placeHolderText()) ? "" : self.imageEditorInputTextView.text
        if let isDelegate = self.delegate {
            isDelegate.didPressSend(text: text)
        } else {
            ImagePreviewLogger.log(message: "ImageEditorTextView has no delegate")
        }
    }
    
    @objc func cancelButtonPressed() {
        if let isDelegate = self.delegate {
            isDelegate.didPressCancel()
        } else {
            ImagePreviewLogger.log(message: "ImageEditorTextView has no delegate")
        }
    }

    //MARK:- Input Text View
    
    private func shouldAdjustInputHeight()-> Bool {
        guard let font = self.imageEditorInputTextView.font else { return false }
        let numberOfLines = Int(self.imageEditorInputTextView.contentSize.height / font.lineHeight)
        return numberOfLines < KMaxAmountOfLines
    }
    
    internal func textViewValueChanged() {
        guard shouldAdjustInputHeight() == true else { return }
        
        let originalY = self.frame.origin.y
        let originalHeight = self.frame.height
        let newHeight = heightForTextInputView()
        let heightDiff = newHeight - originalHeight
        let newY = originalY - heightDiff
        
        self.adjustInputHeight(height: newHeight, y: newY)
        self.adjustTextViewScrollPosition()
    }
    
    private func adjustTextViewScrollPosition() {
        UIView.setAnimationsEnabled(false)
        imageEditorInputTextView.scrollRangeToVisible(NSRange(location: imageEditorInputTextView.text.count, length: 0))
        UIView.setAnimationsEnabled(true)
    }
    
    private func adjustInputHeight(height: CGFloat, y: CGFloat) {
        self.frame.origin.y = y
        self.frame.size.height = height
    }
    
    private func heightForTextInputView() -> CGFloat {
        let contentHeight = self.imageEditorInputTextView.contentSize.height
        if (contentHeight < ImageEditorTextView.defaultHeight) {
            return ImageEditorTextView.defaultHeight
        }
        return contentHeight
    }
}
