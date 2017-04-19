//
//  NSView+Constraints.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 12/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

extension NSView {
    
    var widthConstraint: NSLayoutConstraint? {
        return constraints.first(where: { (c) -> Bool in
            return c.firstAttribute == .width &&
                c.firstAnchor == widthAnchor &&
                c.relation == .equal &&
                c.secondItem == nil &&
                c.secondAnchor == nil
        })
    }
    
    func beginConstraintAnimations(withDuration duration: TimeInterval) {
        
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current().duration = duration
        NSAnimationContext.current().allowsImplicitAnimation = true
    }
    
    func commitConstraintAnimations() {
        
        let view = superview ?? self
        view.layoutSubtreeIfNeeded()
        
        NSAnimationContext.endGrouping()
    }
    
    func runConstraintAnimations(withDuration duration: TimeInterval, animations: @escaping (() -> ())) {
        
        beginConstraintAnimations(withDuration: duration)
        animations()
        commitConstraintAnimations()
    }
}
