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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400.0).isActive = true

        sectionGroup.addSectionView(SectionView(title: "Introdução", color: .intro))
        sectionGroup.addSectionView(SectionView(title: "Livro", color: .book))
        sectionGroup.addSectionView(SectionView(title: "Capítulos", color: .chapter))
        sectionGroup.addSectionView(SectionView(title: "Páginas", color: .page))
        sectionGroup.addSectionView(SectionView(title: "Dicas", color: .hint))
        
        collapseSections()
    }
    
    private func collapseSections() {
        
        let sections = sectionGroup.sections
        for i in 1 ..< sections.count {
            
            let section = sections[i]
            section.widthAnchor.constraint(equalToConstant: SectionView.defaultWidth).isActive = true
        }
    }
}

