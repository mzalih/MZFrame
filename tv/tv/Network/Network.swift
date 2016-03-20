//
//  Network.swift
//  TradeLocker
//
//  Created by Mzalih on 05/01/16.
//  Copyright © 2016 Toobler Technologies. All rights reserved.
//

import Foundation
import MBProgressHUD
import AFNetworking
import Reachability

class Network: NSObject {
    
    static let KEY_CONTENT_TYPE     = "Content-Type"
    static let KEY_APPJSON          = "application/json"
    static let KEY_TEXTHTML         = "text/html"
    static let KEY_FORM             = "application/x-www-form-urlencoded"
    static let KEY_TEXTPLAIN        = "text/plain"
    static let KEY_TEXTJSON         = "text/json"
    static let KEY_TEXTJS           = "text/javascript"
    static let KEY_AUDIOWAV         = "audio/wav"
    static let KEY_IMAGEMIME         = "image/jpeg"
    static let KEY_IMAGETYPE         = ".jpg"
    
    static let METHOD_GET         = "GET"
    static let METHOD_POST         = "POST"
    static let METHOD_PUT         = "PUT"
    static let METHOD_DELETE         = "DELETE"
    
    
    static var showNetWorkError = true
    static func addApiKey(parameters:NSMutableDictionary){
        let apiKey = Config.getApiKey()
        if(apiKey != Constants.KEY_EMPTY){
            parameters.setValue(apiKey, forKey: Constants.REQ_API_KEY)
        }
    }
    
    static func executePostWithUrl( url: String, andParameters parameters: NSMutableDictionary, andHeaders headers: [NSObject : AnyObject]?, withSuccessHandler success: (op:AFHTTPRequestOperation!,obj:AnyObject!,status:Bool) -> Void, withFailureHandler failure: (op:AFHTTPRequestOperation!,err:NSError!) -> Void, withLoadingViewOn parentView: UIView?) {
        
        if (!Network.isDataConnectionAvailable()) {
            //  NSLog("No data connection is available")
            MBProgressHUD.hideAllHUDsForView(parentView, animated: true)
            if((parentView) != nil && showNetWorkError){
                showNetWorkError = false
                Config.showAlert(nil, message:   Constants.ERROR_NETWORK)
            }
            failure(op: AFHTTPRequestOperation(), err: NSError(domain:  Constants.ERROR_NETWORK, code: 0, userInfo: [ Constants.KEY_MESSAGE: Constants.KEY_EMPTY]))
            return
        }
        showNetWorkError = true
        addApiKey(parameters)
        
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.requestSerializer.setValue(KEY_FORM, forHTTPHeaderField: KEY_CONTENT_TYPE)
        
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments) as AFJSONResponseSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:KEY_APPJSON, KEY_TEXTHTML, KEY_TEXTPLAIN, KEY_TEXTJSON, KEY_TEXTJS, KEY_AUDIOWAV) as Set<NSObject>
        // manager.requestSerializer.setValue(token, forHTTPHeaderField: "Authorization")
        
        if (parentView != nil) {
            MBProgressHUD.showHUDAddedTo(parentView, animated: true)
        }
        print(METHOD_GET+url)
        manager.POST(url, parameters: parameters, success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            showLogStatus(operation)
            if (parentView != nil) {
                MBProgressHUD.hideAllHUDsForView(parentView, animated: true)
            }
            if (operation.cancelled) {
                return
            }
            let apiSuccess: Bool = true
            success(op: operation, obj: responseObject, status: apiSuccess)
            if  let res_status:String = responseObject[Constants.RESP_SPECIAL_MESSAGE] as? String{
                // Have a special response here please handle it as a notification
                print(res_status)
                
            }
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                if (parentView != nil) {
                    MBProgressHUD.hideAllHUDsForView(parentView, animated: true)
                    handleFailure(operation,error: error,parentView: parentView!)
                }
                if (operation.cancelled) {
                    return
                }
                failure(op: operation, err: error!)
        })
    }
    static func handleFailure(operation: AFHTTPRequestOperation!, error: NSError!,parentView:UIView){
         MBProgressHUD.hideAllHUDsForView(parentView, animated: true)
    if let data:NSDictionary = operation.responseObject as? NSDictionary{
    if let msg:String = data[Constants.RESP_MESSAGE] as? String{
    if(msg != Constants.KEY_EMPTY){
    Config.showAlert(nil, message: msg)
    }
    }
    
    }else{
    if (operation.responseString != nil) {
    if(operation.responseString != Constants.KEY_EMPTY){
    Config.showAlert(nil, message:Constants.ERROR_NETWORK)
    }
    }
    }
    }
    static func isDataConnectionAvailable() -> Bool {
        return Reachability.reachabilityForInternetConnection().currentReachabilityStatus() != NetworkStatus.NotReachable
    }
    static func executeGETWithUrl( url: String, andParameters parameters: NSMutableDictionary , andHeaders headers: [NSObject : AnyObject]?, withSuccessHandler success: (op:AFHTTPRequestOperation!,obj:AnyObject!,status:Bool) -> Void, withFailureHandler failure: (op:AFHTTPRequestOperation!,err:NSError!) -> Void, withLoadingViewOn parentView: UIView?) {
        addApiKey(parameters)
        if (!Network.isDataConnectionAvailable()) {
            
            MBProgressHUD.hideAllHUDsForView(parentView, animated: true)
            if((parentView) != nil && showNetWorkError){
                showNetWorkError = false
                Config.showAlert(nil, message:   Constants.ERROR_NETWORK)
            }
            failure(op: AFHTTPRequestOperation(), err: NSError(domain:  Constants.ERROR_NETWORK, code: 0, userInfo: [ Constants.MESSAGE_APP_NEME: Constants.KEY_EMPTY]))
            return
        }
        showNetWorkError = true
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.requestSerializer.setValue(KEY_FORM, forHTTPHeaderField: KEY_CONTENT_TYPE)
        
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments) as AFJSONResponseSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:KEY_APPJSON, KEY_TEXTHTML, KEY_TEXTPLAIN, KEY_TEXTJSON, KEY_TEXTJS, KEY_AUDIOWAV) as Set<NSObject>
        // manager.requestSerializer.setValue(token, forHTTPHeaderField: "Authorization")
        
        if (parentView != nil) {
            MBProgressHUD.showHUDAddedTo(parentView, animated: true)
        }
        print(METHOD_GET+url)
        manager.GET(url, parameters: parameters, success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            showLogStatus(operation)
            if (parentView != nil) {
                MBProgressHUD.hideAllHUDsForView(parentView, animated: true)
            }
            if (operation.cancelled) {
                return
            }
            let apiSuccess: Bool = true
            success(op: operation, obj: responseObject, status: apiSuccess)
            
            if  let res_status:String = responseObject[Constants.RESP_SPECIAL_MESSAGE] as? String{
                // Have a special response here please handle it as a notification
                print(res_status)
                
            }
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                if (parentView != nil) {
                    handleFailure(operation, error: error,parentView:parentView! )
                }
                if (operation.cancelled) {
                    return
                }
                failure(op: operation, err: error!)
        })
    }
    static func executePOSTWithUrlandData( url: String, andParameters parameters: NSMutableDictionary , andHeaders headers: [NSObject : AnyObject]?,data:NSData?,name:NSString, withSuccessHandler success: (AFHTTPRequestOperation!,AnyObject!,Bool) -> Void, withFailureHandler failure: (AFHTTPRequestOperation!,NSError!) -> Void, withLoadingViewOn parentView: UIView?) {
        addApiKey(parameters)
        if (!Network.isDataConnectionAvailable()) {
            MBProgressHUD.hideAllHUDsForView(parentView, animated: true)
            if((parentView) != nil && showNetWorkError){
                showNetWorkError = false
                Config.showAlert(nil, message:   Constants.ERROR_NETWORK)
            }
            failure(AFHTTPRequestOperation(), NSError(domain: Constants.ERROR_NETWORK, code: 0, userInfo: [Constants.KEY_MESSAGE:Constants.KEY_EMPTY]))
            return
        }
        showNetWorkError = true
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        
        manager.requestSerializer = AFHTTPRequestSerializer()
        
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments) as AFJSONResponseSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:KEY_APPJSON,KEY_TEXTHTML, KEY_TEXTPLAIN, KEY_TEXTJSON, KEY_TEXTJS, KEY_AUDIOWAV) as Set<NSObject>
        // manager.requestSerializer.setValue(token, forHTTPHeaderField: "Authorization")
        
        if (parentView != nil) {
            MBProgressHUD.showHUDAddedTo(parentView, animated: true)
        }
        
        
        print(METHOD_POST+url)
        manager.POST(url, parameters: parameters, constructingBodyWithBlock: { (formData :AFMultipartFormData!) -> Void in
            if(data != nil){
                formData.appendPartWithFileData(data, name: name as String, fileName: (name as String) + KEY_IMAGETYPE, mimeType: KEY_IMAGEMIME)
            }
            }, success: { (op : AFHTTPRequestOperation!, obj :AnyObject!) -> Void in
                if (parentView != nil) {
                    MBProgressHUD.hideAllHUDsForView(parentView, animated: true)
                }
                showLogStatus(op)
                success(op,obj,true)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                if (parentView != nil) {
                    handleFailure(operation, error: error, parentView: parentView!)
                }
                if (operation.cancelled) {
                    return
                }
                failure(operation, error!)
        }
    }
    // VALIDATE FOR A AUTHKEY ERROR
    static func showLogStatus(operation:AFHTTPRequestOperation!){
        if(operation == nil){
            return
        }
     //   if let data:NSDictionary = operation.responseObject as? NSDictionary{
          //  if let msg:String = data[Constants.RESP_MESSAGE] as? String{
              //  if(msg == Constants.MESSAGE_INVALID_KEY){
                    // IS A WRONG API KEY
                    // LETS LOGOUT AND INFORM USER TO LOGIN AGAIN
                    // LOGOUT CKICKED
                  //  if((AppDelegate.getInstance().menuView) != nil){
                  //      AppDelegate.getInstance().menuView!.onClickLogoff(UIButton())
               //     }
            //    }
         //   }
     //   }
    }
}