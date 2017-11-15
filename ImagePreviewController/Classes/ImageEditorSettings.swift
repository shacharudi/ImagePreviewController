//
//  ImageEditorSettings.swift
//  ImagePreviewController
//
//  Created by Shachar Udi on 11/14/17.
//  Copyright © 2017 Shachar Udi. All rights reserved.
//

import Foundation
import UIKit

struct ImageEditorSettings {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let editorBackgroundColor = UIColor.black
    static let imageViewBackgroundColor = UIColor.black
    static let textViewTextColor = UIColor.black
    static let textViewPlaceholderColor = UIColor.black.withAlphaComponent(0.20)
    static let textViewBorderColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1)
    static let separatorColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:0.5)
    static let sendButtonTintColor = UIColor.blue
    
    static let textViewPaddingInContainer: CGFloat = 4.0
    static let imageEditorTextFieldCornerRadius: CGFloat = 2
    
    static let textViewDefaultFont = UIFont.systemFont(ofSize: 16)
    static let defaultPlaceholderText = "Type a message..."
}

class ImageEditorCustomSettings {
    
    /** Background color for View Controller */
    var IEBackgroundColor: UIColor? = nil
    /** Background color for Image View */
    var IEImageViewBackgroundColor: UIColor? = nil
    /** Text Color for input TextView */
    var IETextViewTextColor: UIColor? = nil
    /** Text Color for input TextView PlaceHolder */
    var IETextViewPlaceholderColor: UIColor? = nil
    /** Border color for input TextView */
    var IETextViewBorderColor: UIColor? = nil
    /** Color for top seperator (above the TextView) */
    var IESeperatorColor: UIColor? = nil
    /** Tint color for send button */
    var IESendButtonTintColor: UIColor? = nil
    /** Input Text View corner radius */
    var IEImageEditorTextFieldCornerRadius: CGFloat? = nil
    /** Top and bottom margin from container */
    var IETextViewMarginInContainer: CGFloat? = nil
    /** Font type and size used in input TextView */
    var IETextViewFont: UIFont? = nil
    /** Placeholder text that appears in TextView */
    var IEPlaceholderText: String? = nil
    /** Icon for Send Button */
    var IESendButtonImage: UIImage?
    /** Icon for Cancel Button */
    var IECancelButtonImage: UIImage?
    
    internal func screenWidth()-> CGFloat {
        return ImageEditorSettings.screenWidth
    }

    internal func screenHeight()-> CGFloat {
        return ImageEditorSettings.screenHeight
    }
    
    internal func editorBackgroundColor()-> UIColor {
        return IEBackgroundColor ?? ImageEditorSettings.editorBackgroundColor
    }
    
    internal func imageViewBackgroundColor()-> UIColor {
        return IEImageViewBackgroundColor ?? ImageEditorSettings.imageViewBackgroundColor
    }
    
    internal func textViewTextColor()-> UIColor {
        return IETextViewTextColor ?? ImageEditorSettings.textViewTextColor
    }
    
    internal func placeholderColor()-> UIColor {
        return IETextViewPlaceholderColor ?? ImageEditorSettings.textViewPlaceholderColor
    }
    
    internal func textViewBorederColor()-> UIColor {
        return IETextViewBorderColor ?? ImageEditorSettings.textViewBorderColor
    }
    
    internal func seperatorColor()-> UIColor {
        return IESeperatorColor ?? ImageEditorSettings.separatorColor
    }
    
    internal func sendButtonTintColor()-> UIColor {
        return IESendButtonTintColor ?? ImageEditorSettings.sendButtonTintColor
    }
    
    internal func textFieldCornerRadius()-> CGFloat {
        return IEImageEditorTextFieldCornerRadius ?? ImageEditorSettings.imageEditorTextFieldCornerRadius
    }
    
    internal func textViewPaddingInContainer()-> CGFloat {
        return IETextViewMarginInContainer ?? ImageEditorSettings.textViewPaddingInContainer
    }
    
    internal func textViewFont()-> UIFont {
        return IETextViewFont ?? ImageEditorSettings.textViewDefaultFont
    }
    
    internal func placeHolderText()-> String {
        return IEPlaceholderText ?? ImageEditorSettings.defaultPlaceholderText
    }
    
    internal func sendButtonImage()-> UIImage {
        if (IESendButtonImage != nil) { return IESendButtonImage! }
        guard let defaultSendImage = UIImage(named: "ic_send") else {
            return UIImage()
        }
        return defaultSendImage
    }
    
    internal func cancelButtonImage()-> UIImage {
        if (IECancelButtonImage != nil) { return IECancelButtonImage! }
        guard let defaultCancelImage = UIImage(named: "ic_close") else {
            return UIImage()
        }
        return defaultCancelImage
    }
    
    
}





