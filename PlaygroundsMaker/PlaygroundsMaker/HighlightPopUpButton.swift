//
//  HighlightPopUpButton.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 19/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class HighlightPopUpButton : NSPopUpButton {
    
    @IBInspectable var highlightColor: NSColor = .black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateChildren(highlightingSelectedItem: true)
    }
    
    private func updateChildren(highlightingSelectedItem: Bool) {
        
        for item in itemArray {
            item.attributedTitle = attributedString(item.title, color: .black)
        }
        
        if highlightingSelectedItem, let item = selectedItem {
            item.attributedTitle = attributedString(item.title, color: highlightColor)
        }
    }
    
    private func attributedString(_ string: String, color: NSColor) -> NSAttributedString {
        
        let string = NSMutableAttributedString(string: string, attributes: [
            NSFontAttributeName: font!,
            NSForegroundColorAttributeName: color
        ])
        
        return string
    }
    
    override func willOpenMenu(_ menu: NSMenu, with event: NSEvent) {
        updateChildren(highlightingSelectedItem: false)
    }
    
    override func didCloseMenu(_ menu: NSMenu, with event: NSEvent?) {
        updateChildren(highlightingSelectedItem: true)
    }
}
