//
//  PagesContentController.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 19/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class PagesContentController : SectionContentController, NSTableViewDelegate, PageDelegate {
    
    @IBOutlet weak var tableView: NSTableView!
    
    var pages = [
        Page(name: "Hello, world!"),
        Page(name: "Hello, world!"),
        Page(name: "Hello, world!")
    ]
    
    init() {
        super.init(nibName: "PagesSectionContent")
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        for page in pages {
            page.delegate = self
        }
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        
        let page = pages[row]
        return page.collapsed ? 70 : 374
    }
    
    func pageWantsToShowDetails(_ page: Page) {
        updatePageHeight(page)
    }
    
    func pageWantsToHideDetails(_ page: Page) {
        updatePageHeight(page)
    }
    
    func updatePageHeight(_ page: Page) {
        
        let indexes = IndexSet(integersIn: 0 ..< pages.count)
        
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current().allowsImplicitAnimation = true
        NSAnimationContext.current().duration = 0.3
        
        if let index = pages.index(of: page) {
            
            if let rowView = tableView.rowView(atRow: index, makeIfNecessary: false) {
                
                var frame = rowView.frame
                frame.size.height = tableView(tableView, heightOfRow: index)
                    
                rowView.frame = frame
            }
            
            tableView.noteHeightOfRows(withIndexesChanged: indexes)
        }
        
        tableView.layoutSubtreeIfNeeded()
        
        NSAnimationContext.endGrouping()
    }
}
