//
//  NSColor+Hexadecimal.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 12/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

extension NSColor {
    
    convenience init?(hex: String) {
        
        var string = hex
        
        if string.hasPrefix("#") {
            string.remove(at: string.startIndex)
        }
        
        if strlen(string) != 6 {
            return nil
        }
        
        guard let value = Int(string, radix: 16) else {
            return nil
        }
        
        let r = CGFloat((value & 0xFF0000) >> 16)
        let g = CGFloat((value & 0x00FF00) >> 8)
        let b = CGFloat((value & 0x0000FF) >> 0)
        
        self.init(
            red: r / 255.0,
            green: g / 255.0,
            blue: b / 255.0,
            alpha: 1.0
        )
    }
}
