//
//  Page.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 19/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

protocol PageDelegate {
    
    func pageWantsToHideDetails(_ page: Page)
    func pageWantsToShowDetails(_ page: Page)
}

class Page : NSObject {
    
    var delegate: PageDelegate?
    var name: String? = ""
    
    var collapsed = true {
        didSet {
            if collapsed {
                delegate?.pageWantsToHideDetails(self)
            }
            else {
                delegate?.pageWantsToShowDetails(self)
            }
        }
    }
    
    init(name: String) {
        super.init()
        self.name = name
    }
}
