//
//  SectionContentController.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 17/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class SectionContentController: NSViewController {

    var wantsHeader: Bool { return false }
    
    init(nibName: String) {
        super.init(nibName: nibName, bundle: nil)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
