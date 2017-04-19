//
//  PagesContentController.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 19/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class PagesContentController : SectionContentController {
    
    init() {
        super.init(nibName: "PagesSectionContent")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
