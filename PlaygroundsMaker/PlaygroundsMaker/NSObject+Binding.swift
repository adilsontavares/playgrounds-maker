//
//  NSObject+Binding.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 20/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

extension NSObject {
    
    func bindTwoWay(between item1: NSObject, forKey key1: String, and item2: NSObject, forKey key2: String, options: [String: Any]? = nil) {
        
        var options = options
        
        if options != nil && options![NSContinuouslyUpdatesValueBindingOption] == nil {
            options![NSContinuouslyUpdatesValueBindingOption] = true
        }
        
        item1.bind(key1, to: item2, withKeyPath: key2, options: options)
        item2.bind(key2, to: item1, withKeyPath: key1, options: options)
    }
}
