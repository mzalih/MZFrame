//
//  MZTableView.swift
//  tv
//
//  Created by Muhammed Salih on 20/03/16.
//  Copyright © 2016 Muhammed Salih T A. All rights reserved.
//

import UIKit

@IBDesignable
class MZTableView: UITableView,UITableViewDataSource {
    
    var requirePagination       = true
    var paginationCount       = 20
    var showLoading             = true
    
    @IBInspectable var loadingIndicator: Bool {
        get {
            return showLoading;
        }
        set {
            showLoading = loadingIndicator
        }
    }
    var pulltoreload            = true
    
    @IBInspectable var pullReload: Bool {
        get {
            return pulltoreload;
        }
        set {
            pulltoreload = pullReload
        }
    }
    private var showEmptyDataMessage    = false
    var isInitialLoad           = true
    var emptyDataMessage:String
        {
        set
        {
            if(emptyDataMessage != MZBase.NULL)
                {
            showEmptyDataMessage = true
                }
            else
            {
                showEmptyDataMessage = false
                
            }
        }
        get {
            return self.emptyDataMessage
        }
    }
    
    @IBInspectable var emptyMessage: String {
        get {
            return emptyDataMessage;
        }
        set {
            emptyDataMessage = emptyMessage
        }
    }
    
    var identifier = "ItemCell"
    @IBInspectable var CellIdentifier: String {
        get {
            return identifier;
        }
        set {
            identifier = CellIdentifier
        }
    }
    
    let dataArray  = NSMutableArray()
    
    
    func MZTableView(){
        self.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = createCell(tableView, cellForRowAtIndexPath: indexPath);
        cell.setCellData(getItem(indexPath))
        return cell
    }
    func createCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MZTableViewCell {
        if let cell:MZTableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier) as? MZTableViewCell{
            return cell
        }
        return MZTableViewCell();
    }
   
    func getItem(indexPath:NSIndexPath)->MZItem{
        if(dataArray.count >= indexPath.row){
            if let item:MZItem = dataArray.objectAtIndex(indexPath.row) as?MZItem{
                return item
            }
        }
        let item = MZItem();
        item.value1 = "loading"
        return item
    }
    func fetchData(){
        MZTableView();
        Connect.fetchData { (status, data) -> Void in
        self.dataArray.addObjectsFromArray(data as [AnyObject])
            self.reloadData()
        }
    }
}
