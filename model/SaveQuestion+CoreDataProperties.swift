//
//  SaveQuestion+CoreDataProperties.swift
//  medical
//
//  Created by Y YM on 2020/11/7.
//  Copyright © 2020 edu. All rights reserved.
//
//

import Foundation
import CoreData


extension SaveQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveQuestion> {
        return NSFetchRequest<SaveQuestion>(entityName: "SaveQuestion")
    }

    @NSManaged public var username: String?
    @NSManaged public var topic: String?
    @NSManaged public var question: Question?

}
