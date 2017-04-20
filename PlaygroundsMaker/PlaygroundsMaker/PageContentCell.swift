//
//  PageContentCell.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 20/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class PageContentCell : NSTableCellView {
    
    @IBOutlet weak var liveViewPreview: LiveViewPreview!
    @IBOutlet weak var posterView: NSImageView!
    
    @IBOutlet weak var showsLiveViewButton: NSButton!
    @IBOutlet weak var fillLiveViewButton: NSButton!
    @IBOutlet weak var showsResultsButton: NSButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindTwoWay(between: liveViewPreview, forKey: "showsLiveView", and: showsLiveViewButton.cell!, forKey: "state")
        bindTwoWay(between: liveViewPreview, forKey: "showsResults", and: showsResultsButton.cell!, forKey: "state")
        
        bindTwoWay(between: liveViewPreview, forKey: "liveViewFloats", and: fillLiveViewButton.cell!, forKey: "state", options: [
            NSValueTransformerNameBindingOption: NSValueTransformerName.negateBooleanTransformerName
        ])
    }
}
