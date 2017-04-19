//
//  NavigationArrow.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 18/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

@IBDesignable
class NavigationArrow: NSView {

    @IBInspectable var forward: Bool = true
    @IBInspectable var color: NSColor! = .lightGray
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let fromX: CGFloat
        let toX: CGFloat
        
        if forward {
            fromX = 0.0
            toX = bounds.width
        }
        else {
            fromX = bounds.width
            toX = 0.0
        }
        
        let path = NSBezierPath()
        path.move(to: NSPoint(x: fromX, y: 0.0))
        path.line(to: NSPoint(x: fromX, y: bounds.height))
        path.line(to: NSPoint(x: toX, y: bounds.height * 0.5))
        path.close()
        
        color.setFill()
        path.fill()
    }
}
