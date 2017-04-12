//
//  SectionView.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 12/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

protocol SectionViewDelegate {
    
    func sectionViewWantsToOpen(_ sectionView: SectionView)
}

class SectionView: NSView {

    static let defaultWidth: CGFloat = 56.0
    
    var titleButton: NSButton!
    var delegate: SectionViewDelegate?
    
    var color: NSColor
    var titleColor: NSColor {
        return color.shadow(withLevel: 0.4)!
    }
    
    init(title: String, color: NSColor) {
        
        self.color = color
        
        super.init(frame: .zero)
        
        setup()
        
        layer!.backgroundColor = color.cgColor
        setTitle(title)
    }
    
    private func setup() {
        
        widthAnchor.constraint(greaterThanOrEqualToConstant: SectionView.defaultWidth).isActive = true
        
        titleButton = NSButton(title: "", target: self, action: #selector(titleButtonClicked(_:)))
        titleButton.isBordered = false
        titleButton.frame = CGRect(x: 0, y: 0, width: SectionView.defaultWidth, height: self.frame.height)
        titleButton.autoresizingMask = .viewHeightSizable
        titleButton.translatesAutoresizingMaskIntoConstraints = true
        titleButton.rotate(byDegrees: -90)
        addSubview(titleButton)
        
        wantsLayer = true
    }
    
    func setTitle(_ title: String) {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let text = NSMutableAttributedString(string: title.uppercased(), attributes: [
            NSForegroundColorAttributeName: titleColor,
            NSParagraphStyleAttributeName: paragraph,
            NSFontAttributeName: NSFont(name: "HelveticaNeue-Bold", size: 24.0)!,
        ])
        
        titleButton.attributedTitle = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func titleButtonClicked(_ sender: NSButton) {
        delegate?.sectionViewWantsToOpen(self)
    }
}
