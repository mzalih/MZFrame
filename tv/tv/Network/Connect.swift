//
//  Connect.swift
//  tv
//
//  Created by Muhammed Salih on 20/03/16.
//  Copyright © 2016 Muhammed Salih T A. All rights reserved.
//

import UIKit

class Connect: NSObject {
    
    static func fetchData(response:(status:Bool,data:NSMutableArray)->Void){
    let url = "http://www.json-generator.com/api/json/get/cfnxqOBxKa?indent=4"
        Network.executeGETWithUrl(url, andParameters: NSMutableDictionary(), andHeaders: nil, withSuccessHandler: { (op, obj, status) -> Void in
           let  array = NSMutableArray()
            if let dat:NSArray = obj as? NSArray {
                
                for item in dat
                {
                    array.addObject(HomeItem().parse(item as! NSDictionary));
                }
                response(status: true,data: array);
            }
            
            }, withFailureHandler: { (op, err) -> Void in
                
            }, withLoadingViewOn: nil)
        
    }
 
}
       