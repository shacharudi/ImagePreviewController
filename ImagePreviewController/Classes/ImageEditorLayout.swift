//
//  ImageEditorLayout.swift
//  ImagePreviewController
//
//  Created by Shachar Udi on 11/14/17.
//  Copyright © 2017 Shachar Udi. All rights reserved.
//

import Foundation
import UIKit

enum DimentionSelector {
    case width, height
    
    func ALAttribute()-> NSLayoutAttribute {
        switch self {
        case .height:
            return NSLayoutAttribute.height
        case .width:
            return NSLayoutAttribute.width
        }
    }
}

extension UIView {
    func pinToSuperviewEdges() {
        guard let isSuperView = self.superview else {
            fatalError("ImageEditor AutoLayout Error: View has no superview!")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        isSuperView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        isSuperView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }
    
    
    func pinToSuperviewEdge(edge: NSLayoutAttribute, toEdge: NSLayoutAttribute, margin: CGFloat? = 0) {
        guard let isSuperView = self.superview else {
            fatalError("ImageEditor AutoLayout Error: View has no superview!")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        isSuperView.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: edge,
                relatedBy: .equal,
                toItem: isSuperView,
                attribute: toEdge,
                multiplier: 1.0,
                constant: margin ?? 0
        ))
    }
    
    func pinToViewEdge(edge: NSLayoutAttribute, toEdge: NSLayoutAttribute, ofView: UIView, margin: CGFloat? = 0) {
        guard let isSuperView = self.superview else {
            fatalError("ImageEditor AutoLayout Error: View has no superview!")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        isSuperView.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: edge,
                relatedBy: .equal,
                toItem: ofView,
                attribute: toEdge,
                multiplier: 1.0,
                constant: margin ?? 0
        ))
    }
    
    func setAutoLayoutDimention(dimention: DimentionSelector, value: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch dimention {
        case .height:
            self.heightAnchor.constraint(equalToConstant: value).isActive = true
        case .width:
            self.widthAnchor.constraint(equalToConstant: value).isActive = true
        }
    }
}
