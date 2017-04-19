//
//  IntroContentController.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 17/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class IntroContentController: SectionContentController {
    
    override var wantsHeader: Bool { return true } 
    
    init() {
        super.init(nibName: "IntroSectionContent")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
