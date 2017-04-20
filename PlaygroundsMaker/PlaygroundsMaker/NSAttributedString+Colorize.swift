//
//  NSAttributedString+Colorize.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 19/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

extension NSAttributedString {
    
    func colorized(with color: NSColor) -> NSAttributedString {
        return extendingAttribute(key: NSForegroundColorAttributeName, value: color)
    }
    
    func extendingAttribute(key: String, value: Any) -> NSAttributedString {
        return extendingAttributes([key: value])
    }
    
    func extendingAttributes(_ attributes: [String: Any]) -> NSAttributedString {
        
        let string = NSMutableAttributedString(attributedString: self)
        string.setAttributes(attributes, range: NSRange(location: 0, length: length))
        
        return string
    }
}
