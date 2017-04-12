//
//  SectionGroupView.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 12/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class SectionGroupView: NSStackView, SectionViewDelegate {

    private(set) var currentSection: SectionView?
    private(set) var sections = [SectionView]()
    
    func addSectionView(_ sectionView: SectionView) {
        
        if sections.isEmpty {
            currentSection = sectionView
        }
        
        sectionView.delegate = self
        
        sections.append(sectionView)
        addArrangedSubview(sectionView)
    }
    
    func openSection(_ section: SectionView) {
        
        if let index = sections.index(of: section) {
            openSection(at: index)
        }
    }
    
    func openSection(at index: Int) {
        
        if index < 0 || index >= sections.count {
            return
        }
        
        let newSection = sections[index]
        if newSection == currentSection {
            return
        }
        
        let collapsedWidth = SectionView.defaultWidth
        let openedWidth = self.frame.width - (SectionView.defaultWidth * CGFloat(sections.count - 1))
        
        layer!.backgroundColor = currentSection?.color.cgColor
        
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current().allowsImplicitAnimation = true
        NSAnimationContext.current().duration = 0.3
        
        currentSection?.widthConstraint?.constant = collapsedWidth
        newSection.widthConstraint?.constant = openedWidth
        
        superview?.layoutSubtreeIfNeeded()
        NSAnimationContext.endGrouping()
        
        currentSection = newSection
    }
    
    func sectionViewWantsToOpen(_ sectionView: SectionView) {
        openSection(sectionView)
    }
}
