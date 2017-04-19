//
//  Chapter.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 18/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class Chapter: NSObject {

    var name: String?
    
    override init() {
        super.init()
        name = nil
    }
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    var isLeaf: Bool {
        return true
    }
}
