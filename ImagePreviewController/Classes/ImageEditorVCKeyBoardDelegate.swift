//
//  ImageEditorVCKeyBoardDelegate.swift
//  Gefen
//
//  Created by Shachar Udi on 11/12/17.
//  Copyright © 2017 Gefen. All rights reserved.
//

import Foundation
import UIKit

extension ImageEditorViewController {

    @objc internal func keyboardFrameChanged(notification: NSNotification) {
        self.didChangeNotif(notification: notification)
    }
    
    @objc internal func keyboardWillShow(notification: NSNotification) {
        self.didChangeNotif(notification: notification)
        self.editorImageView.setEditingMode()
    }
    
    @objc internal func keyboardWillHide(notification: NSNotification) {
        self.didChangeNotif(notification: notification)
        self.editorImageView.setPreviewMode()
    }
    
    internal func didChangeNotif(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let convertedEndFrame = self.view.convert(frame, to: nil)
        
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
            self.textInputView.frame.origin.y = convertedEndFrame.origin.y - self.textInputView.frame.size.height
        }, completion: nil)
    }
}
