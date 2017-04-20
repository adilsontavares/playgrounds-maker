//
//  NSButton+TextColor.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 19/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

extension NSButton {
    
    @IBInspectable var titleColor: NSColor? {
        get { return nil }
        set {
            if let color = newValue {
                updateTitle(withColor: color)
            } else {
                title = attributedTitle.string
            }
        }
    }
    
//    open override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        if let color = titleColor {
//            updateTitle(withColor: color)
//        }
//    }
    
    private func updateTitle(withColor color: NSColor) {
        
        attributedTitle = NSAttributedString(string: title, attributes: [
            NSForegroundColorAttributeName: color,
            NSFontAttributeName: font!
        ])
    }
}
