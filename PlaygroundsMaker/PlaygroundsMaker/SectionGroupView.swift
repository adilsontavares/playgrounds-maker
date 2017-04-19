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
        
        sectionView.delegate = self
        
        sections.append(sectionView)
        addArrangedSubview(sectionView)
        
        if sections.count == 1 {
            openSection(at: 0, animated: false)
        }
    }
    
    func openNextSection(animated: Bool = true) {
        
        if let index = indexOf(section: currentSection) {
            openSection(at: index + 1)
        }
    }
    
    func openPreviousSection(animated: Bool = true) {
        
        if let index = indexOf(section: currentSection) {
            openSection(at: index - 1)
        }
    }
    
    func openSection(_ section: SectionView, animated: Bool = true) {
        
        if let index = sections.index(of: section) {
            openSection(at: index, animated: animated)
        }
    }
    
    func indexOf(section: SectionView?) -> Int? {
        
        if section == nil {
            return nil
        }
        
        return sections.index(where: { (s) -> Bool in
            return s == section
        })
    }
    
    func openSection(at index: Int, animated: Bool = true) {
        
        if index < 0 || index >= sections.count {
            return
        }
        
        let newSection = sections[index]
        if newSection == currentSection {
            return
        }
        
        currentSection?.close(animated: animated)
        newSection.open(animated: animated)
        
        currentSection = newSection
    }
    
    func sectionViewWantsToOpen(_ sectionView: SectionView) {
        openSection(sectionView)
    }
}
