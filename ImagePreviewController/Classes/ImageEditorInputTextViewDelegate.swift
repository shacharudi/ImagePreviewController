//
//  ImageEditorInputTextViewDelegate.swift
//  Gefen
//
//  Created by Shachar Udi on 11/13/17.
//  Copyright © 2017 Gefen. All rights reserved.
//

import Foundation
import UIKit

extension ImageEditorTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == placeHolderText()) {
            removePlaceholderText()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text.count == 0) {
            setPlaceholderText()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.textViewValueChanged()
    }
    
    private func placeHolderText()-> String {
        return self.settings.placeHolderText()
    }
    
    internal func setPlaceholderText() {
        self.imageEditorInputTextView.text = placeHolderText()
        self.imageEditorInputTextView.textColor = self.settings.placeholderColor()
    }
    
    private func removePlaceholderText() {
        self.imageEditorInputTextView.text = ""
        self.imageEditorInputTextView.textColor = self.settings.textViewTextColor()
    }
}
