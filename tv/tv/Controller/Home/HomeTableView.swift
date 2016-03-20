//
//  HomeTableView
//  tv
//
//  Created by Muhammed Salih on 20/03/16.
//  Copyright © 2016 Muhammed Salih T A. All rights reserved.
//

import UIKit

class HomeTableView: MZTableView {
    
    func HomeTableView(){
        identifier = "ItemCell"
    }
    override func getItem(indexPath: NSIndexPath) -> MZItem {
        let  item = super.getItem(indexPath);
        return item
    }
}
