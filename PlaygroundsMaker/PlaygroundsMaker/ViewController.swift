//
//  ViewController.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 12/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var sectionGroup: SectionGroupView!
    
    var document: Document? {
        return self.view.window?.windowController?.document as? Document
    }
    
    override var acceptsFirstResponder: Bool { return true }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sectionGroup.addSectionView(SectionView(title: "Introdução", color: .intro, controller: IntroContentController()))
        sectionGroup.addSectionView(SectionView(title: "Livro", color: .book, controller: BookContentController()))
        sectionGroup.addSectionView(SectionView(title: "Capítulos", color: .chapter, controller: ChaptersContentController()))
        sectionGroup.addSectionView(SectionView(title: "Páginas", color: .page, controller: PagesContentController()))
//        sectionGroup.addSectionView(ChaptersSection())
//        sectionGroup.addSectionView(PagesSection())
//        sectionGroup.addSectionView(HintsSection())
        
        sectionGroup.openSection(at: 3, animated: false)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.makeFirstResponder(self)
    }
    
    override func swipe(with event: NSEvent) {
        
        let threshold: CGFloat = 0.5
        
        if abs(event.deltaY) >= threshold {
            return
        }
        
        if event.deltaX >= threshold {
            sectionGroup.openNextSection()
        }
        else if event.deltaX <= -threshold {
            sectionGroup.openPreviousSection()
        }
    }
    
    override func keyDown(with event: NSEvent) {
        
        guard let characters = event.characters, strlen(characters) == 1 else {
            return
        }
        
        if let num = Int(characters, radix: 10), num >= 1 && num <= sectionGroup.sections.count {
            sectionGroup.openSection(at: num - 1)
        }
        else {
            super.keyDown(with: event)
        }
    }
}

