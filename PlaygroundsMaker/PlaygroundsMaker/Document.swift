//
//  Document.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 12/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    var title: String = "No content..."

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override func makeWindowControllers() {
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
        
        self.addWindowController(windowController)
        
//        let controller = BookContentController()
//        
//        let window = NSWindow()
//        window.styleMask = [window.styleMask, NSWindowStyleMask.resizable]
//        
//        let windowController = NSWindowController(window: window)
//        windowController.contentViewController = controller
//        
//        self.addWindowController(windowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        return title.data(using: .utf8)!
    }

    override func read(from data: Data, ofType typeName: String) throws {
        title = String(bytes: data, encoding: .utf8)!
    }
}

