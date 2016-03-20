//
//  MZTableViewCell.swift
//  tv
//
//  Created by Muhammed Salih on 20/03/16.
//  Copyright © 2016 Muhammed Salih T A. All rights reserved.
//

import UIKit
import Haneke


class MZTableViewCell: UITableViewCell {
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(item:MZItem){
       
        if let text = item.value1 as?String{
                textLabel?.text = text
        }
        if let text = item.value4 as?String{
            detailTextLabel?.text = text
        }
        
        
    }

}
