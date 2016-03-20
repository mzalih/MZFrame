//
//  MZItem.swift
//  tv
//
//  Created by Muhammed Salih on 20/03/16.
//  Copyright © 2016 Muhammed Salih T A. All rights reserved.
//

import UIKit

class MZItem: NSObject {
    
     var value1: AnyObject?
     var value2: AnyObject?
     var value3: AnyObject?
     var value4: AnyObject?
     var value5: AnyObject?
     var value6: AnyObject?
    
    var key1: String      = MZBase.NULL
    var key2: String      = MZBase.NULL
    var key3: String      = MZBase.NULL
    var key4: String      = MZBase.NULL
    var key5: String      = MZBase.NULL
    var key6: String      = MZBase.NULL
    
    
    
    func parse(data:NSDictionary)->MZItem{
        
        if let resp = data[key1]{
           value1 = resp
        }
        if let resp = data[key2]{
            value2 = resp
        }
        if let resp = data[key3]{
            value3 = resp
        }
        if let resp = data[key4]{
            value4 = resp
        }
        if let resp = data[key5]{
            value5 = resp
        }
        if let resp = data[key6]{
            value6 = resp
        }
    return self
    }
}
