//
//  SectionContentHeader.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 19/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class SectionContentHeader: NSViewController {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descriptionLabel: NSTextField!
    
    var headerTitle: String = "" {
        didSet {
            titleLabel?.attributedStringValue = attributedText(forString: headerTitle, for: titleLabel)
        }
    }
    
    var headerDescription: String = "" {
        didSet {
            descriptionLabel?.attributedStringValue = attributedText(forString: headerDescription, for: descriptionLabel)
        }
    }
    
    var color: NSColor = .gray {
        didSet {
            headerTitle = String(headerTitle) ?? ""
            headerDescription = String(headerDescription) ?? ""
        }
    }
    
    init(title: String, description: String) {
        
        super.init(nibName: "SectionContentHeader", bundle: nil)!
        
        headerTitle = title
        headerDescription = description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerTitle = String(headerTitle)
        headerDescription = String(headerDescription)
    }
    
    private func attributedText(forString string: String, for textField: NSTextField) -> NSAttributedString {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let text = NSMutableAttributedString(string: string, attributes: [
            NSForegroundColorAttributeName: color,
            NSParagraphStyleAttributeName: paragraph,
            NSFontAttributeName: textField.font!
        ])
        
        return text
    }
}
