//
//  NSView+BackgroundColor.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 17/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

extension NSView {
    
    var backgroundColor: NSColor? {
        get {
            if let color = layer?.backgroundColor {
                return NSColor(cgColor: color)
            }
            return nil
        }
        set {
            
            if let color = newValue {
                wantsLayer = true
                layer!.backgroundColor = color.cgColor
            }
            else {
                layer!.backgroundColor = nil
            }
        }
    }
}
