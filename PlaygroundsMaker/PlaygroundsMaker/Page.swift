//
//  Page.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 19/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class Page : NSObject {
    
    var name: String? = ""
    
    init(name: String) {
        super.init()
        self.name = name
    }
}
