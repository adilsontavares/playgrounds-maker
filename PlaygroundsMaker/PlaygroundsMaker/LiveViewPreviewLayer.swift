//
//  LiveViewPreviewLayer.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 19/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class LiveViewPreviewLayer : CALayer {
    
    @IBInspectable var color = NSColor(hex: "A547FF")!
    @IBInspectable var codeLineCount: Int = 12
    
    private let codeColor = NSColor(hex: "CFCFCF")!
    private let lineWidthPercent: CGFloat = 0.045
    private let cornerRadiusPercent: CGFloat = 0.05
    private let codeSpacingPercent: CGFloat = 0.35
    private let codeMarginPercent: CGFloat = 0.1
    private let liveViewFloatOffsetPercent: CGFloat = 0.16
    private let liveViewShadowOpacity: CGFloat = 0.33
    private let logWidthPercent: CGFloat = 0.12
    
    var showLogPercent: CGFloat = 1.0
    var liveViewShowPercent: CGFloat = 1.0
    var liveViewFloatPercent: CGFloat = 1.0
    
    private var minSize: CGFloat {
        return min(bounds.width, bounds.height)
    }
    
    private var frameThickness: CGFloat {
        return minSize * lineWidthPercent
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        
        if (key == "liveViewFloatPercent" || key == "liveViewShowPercent") {
            return true
        }
        
        return super.needsDisplay(forKey: key)
    }
    
    override func draw(in ctx: CGContext) {
        
        let frameThickness = self.frameThickness
        let rect = self.bounds.insetBy(dx: frameThickness * 0.5, dy: frameThickness * 0.5)
        let contentRect = rect
        
        var codeRect = contentRect
        codeRect.size.width = codeRect.width * 0.5 * (2.0 - liveViewShowPercent)
        
        var liveViewRect = contentRect
        liveViewRect.origin.x = codeRect.maxX
        liveViewRect.size.width = contentRect.width - codeRect.width
        
        var logRect = contentRect
        logRect.size.width *= logWidthPercent * showLogPercent * 0.5
        logRect.origin.x = min(bounds.maxX - frameThickness, codeRect.maxX) - logRect.width
        
        drawCode(on: ctx, rect: codeRect)
        drawLog(on: ctx, rect: logRect)
        drawLiveView(on: ctx, rect: liveViewRect)
        drawFrame(on: ctx, rect: rect)
    }
    
    private func drawLog(on ctx: CGContext, rect: NSRect) {
        
        let count = 8
        let size = rect.width * 0.5
        let x = rect.midX
        let cornerRadius = size * 0.3
    
        for i in 0 ..< count {
            
            let ratio = CGFloat(i + 1) / CGFloat(count + 1)
            let y = rect.height * ratio
            
            let frame = CGRect(origin: CGPoint(x: x, y: y), size: .zero).insetBy(dx: -size * 0.5, dy: -size * 0.5)
            
            let path = CGPath(roundedRect: frame, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
            ctx.addPath(path)
        }
        
        ctx.setFillColor(NSColor.black.withAlphaComponent(0.15).cgColor)
        ctx.fillPath()
    }
    
    private func drawLiveView(on ctx: CGContext, rect: NSRect) {
        
        let base = CGPath(rect: rect, transform: nil)
        
        ctx.setFillColor(color.highlight(withLevel: 0.6)!.cgColor)
        ctx.addPath(base)
        ctx.fillPath()
        
        let viewOffset = minSize * liveViewFloatOffsetPercent * liveViewFloatPercent * 0.5
        var viewRect = rect.insetBy(dx: viewOffset, dy: viewOffset + liveViewFloatPercent * frameThickness * 0.5)
        viewRect.size.width -= frameThickness * 0.5 * liveViewFloatPercent
        
        ctx.saveGState()
        
        let shadowColor = NSColor.black.withAlphaComponent(liveViewFloatPercent * liveViewShadowOpacity)
        ctx.setShadow(offset: .zero, blur: viewOffset, color: shadowColor.cgColor)
        
        let view = CGPath(rect: viewRect, transform: nil)
        ctx.setFillColor(color.cgColor)
        ctx.addPath(view)
        ctx.fillPath()
        
        ctx.restoreGState()
    }
    
    private func drawCode(on ctx: CGContext, rect: NSRect) {
        
        let path = CGPath(rect: rect, transform: nil)
        
        ctx.setFillColor(NSColor.white.cgColor)
        ctx.addPath(path)
        ctx.fillPath()
        
        ctx.beginPath()
        ctx.setFillColor(codeColor.cgColor)
        
        let margin = bounds.height * codeMarginPercent
        let deltaPos = (bounds.height - margin * 2.0) / CGFloat(codeLineCount)
        let spacing = deltaPos * codeSpacingPercent
        let codeH = deltaPos - spacing
        let maxW = (bounds.width * 0.5 - margin * 2.0) * 0.9
        let minW = maxW * 0.5
        let maxAngle = CGFloat.pi * 5.0
        
        for i in 0 ..< codeLineCount {
            
            let angle = (CGFloat(i) / CGFloat(codeLineCount - 1)) * maxAngle
            let pos = margin + deltaPos * CGFloat(i)
            let width = minW + (cos(angle) * 0.5 + 0.5) * (maxW - minW)
            
            ctx.addRect(CGRect(x: margin, y: pos, width: width, height: codeH))
        }
        
        ctx.fillPath()
    }
    
    private func drawFrame(on ctx: CGContext, rect: NSRect) {
        
        let cornerRadius = minSize * cornerRadiusPercent
        let path = CGPath(roundedRect: rect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
        
        ctx.saveGState()
        
        ctx.setLineWidth(frameThickness)
        ctx.setStrokeColor(color.cgColor)
        ctx.addPath(path)
        ctx.strokePath()
        
        ctx.restoreGState()
    }
}
