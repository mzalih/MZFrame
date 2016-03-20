//
//  Menu.swift
//  tv
//
//  Created by Muhammed Salih on 19/03/16.
//  Copyright © 2016 Muhammed Salih T A. All rights reserved.
//

import UIKit
import LGSideMenuController

class Menu: UIView {
    
    let openStyle = LGSideMenuPresentationStyle.ScaleFromBig
    
    private static var menuInstance:Menu!;
    var sideMenu:LGSideMenuController!;
    
    private class func getView() -> Menu {
        return UINib(nibName: "Menu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! Menu
    }
    static func getInstance()->Menu{
        if((menuInstance) == nil){
            menuInstance = getView();
        }
        return menuInstance;
    }
    static func getMainView()->UIViewController{
        let storyboard:UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        
        let navigationController:UINavigationController  = storyboard.instantiateInitialViewController() as! UINavigationController
        return navigationController;
    }
    
   static func getHomePage()->LGSideMenuController{
    
    let menuView = Menu.getInstance();
     menuView.sideMenu = LGSideMenuController(rootViewController: getMainView())
        
        menuView.sideMenu!.setLeftViewEnabledWithWidth(250.0, presentationStyle: menuView.openStyle, alwaysVisibleOptions: LGSideMenuAlwaysVisibleOptions.OnNone)
    
    
        menuView.frame = menuView.sideMenu.view.frame;
    
        menuView.sideMenu!.leftView().addSubview(menuView)
    
        return menuView.sideMenu!;
        
    }
    
    


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
