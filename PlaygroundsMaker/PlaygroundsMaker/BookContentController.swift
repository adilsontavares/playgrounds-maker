//
//  BookContentController.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 17/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class BookContentController: SectionContentController {
    
    init() {
        super.init(nibName: "BookSectionContent")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
