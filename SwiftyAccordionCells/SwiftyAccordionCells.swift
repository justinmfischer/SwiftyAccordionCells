//
//  SwiftyAccordionCells.swift
//  SwiftyAccordionCells
//
//  Created by Fischer, Justin on 9/24/15.
//  Copyright © 2015 Justin M Fischer. All rights reserved.
//

import Foundation

class SwiftyAccordionCells {
    private (set) var items = [Item]()
    
    class Item {
        var isHidden: Bool
        var value: AnyObject
        
        init(_ hidden: Bool = true, value: AnyObject) {
            self.isHidden = hidden
            self.value = value
        }
    }
    
    class HeaderItem: Item {
        init (value: AnyObject) {
            super.init(false, value: value)
        }
    }
    
    func append(item: Item) {
        self.items.append(item)
    }
    
    func removeAll() {
        self.items.removeAll()
    }
    
    func expand(headerIndex: Int) {
        self.toogleVisible(headerIndex, isHidden: false)
    }
    
    func collapse(headerIndex: Int) {
        self.toogleVisible(headerIndex, isHidden: true)
    }
    
    private func toogleVisible(var headerIndex: Int, isHidden: Bool) {
        headerIndex += 1
        
        while headerIndex < self.items.count && !(self.items[headerIndex] is HeaderItem) {
            self.items[headerIndex].isHidden = isHidden
            
            headerIndex += 1
        }
    }
}