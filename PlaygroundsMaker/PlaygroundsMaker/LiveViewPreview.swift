//
//  LiveViewPreview.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 19/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class LiveViewPreview: NSView {
    
    var liveViewFloats = true {
        didSet {
            willChangeValue(forKey: "liveViewFloats")
            animateProperties()
            didChangeValue(forKey: "liveViewFloats")
        }
    }
    
    var showsLiveView = true {
        didSet {
            willChangeValue(forKey: "showsLiveView")
            animateProperties()
            didChangeValue(forKey: "showsLiveView")
        }
    }
    
    var showsResults = false {
        didSet {
            willChangeValue(forKey: "showsResults")
            animateProperties()
            didChangeValue(forKey: "showsResults")
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        
        layer = LiveViewPreviewLayer()
        layerContentsRedrawPolicy = .onSetNeedsDisplay
        wantsLayer = true
    }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        layer!.contentsScale = window?.backingScaleFactor ?? 1.0
    }
    
    override func mouseDown(with event: NSEvent) {
        
        let location = self.convert(event.locationInWindow, from: nil)
        
        if showsLiveView {
            if location.x >= bounds.width * 0.5 {
                toggleLiveViewFloats()
            }
            else {
                toggleShowsLiveView()
            }
        }
        else {
            toggleShowsLiveView()
        }
    }
    
    func toggleLiveViewFloats() {
        liveViewFloats = !liveViewFloats
    }
    
    func toggleShowsLiveView() {
        showsLiveView = !showsLiveView
    }
    
    func animateProperty(forKey key: String, from: CGFloat, to: CGFloat) {
        
        let anim = CABasicAnimation(keyPath: key)
        anim.duration = 0.3
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        anim.fromValue = from
        anim.toValue = to
        layer!.add(anim, forKey: key)
        
        layer!.setValue(to, forKey: key)
    }
    
    func animateProperties() {
        
        if let layer = self.layer as? LiveViewPreviewLayer {
        
            let floatPercent: CGFloat = liveViewFloats ? 1.0 : 0.0
            animateProperty(forKey: "liveViewFloatPercent", from: layer.liveViewFloatPercent, to: floatPercent)
            
            let showPercent: CGFloat = showsLiveView ? 1.0 : 0.0
            animateProperty(forKey: "liveViewShowPercent", from: layer.liveViewShowPercent, to: showPercent)
            
            let resultsPercent: CGFloat = showsResults ? 1.0 : 0.0
            animateProperty(forKey: "showResultsPercent", from: layer.showResultsPercent, to: resultsPercent)
        }
    }
}
