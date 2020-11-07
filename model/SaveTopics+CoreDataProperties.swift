//
//  SaveTopics+CoreDataProperties.swift
//  medical
//
//  Created by Y YM on 2020/11/7.
//  Copyright © 2020 edu. All rights reserved.
//
//

import Foundation
import CoreData


extension SaveTopics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveTopics> {
        return NSFetchRequest<SaveTopics>(entityName: "SaveTopics")
    }

    @NSManaged public var username: String?
    @NSManaged public var topic: Topic?

}
