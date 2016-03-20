//
//  Item+CoreDataProperties.swift
//  tv
//
//  Created by Muhammed Salih on 20/03/16.
//  Copyright © 2016 Muhammed Salih T A. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var title: String?
    @NSManaged var details: String?
    @NSManaged var imageUrl: String?
    @NSManaged var pid: String?
    @NSManaged var detailUrl: String?
    @NSManaged var price: String?

}
