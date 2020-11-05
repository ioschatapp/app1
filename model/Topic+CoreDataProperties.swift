//
//  Topic+CoreDataProperties.swift
//  medical
//
//  Created by Y YM on 2020/11/5.
//  Copyright © 2020 edu. All rights reserved.
//
//

import Foundation
import CoreData


extension Topic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic> {
        return NSFetchRequest<Topic>(entityName: "Topic")
    }

    @NSManaged public var topic: String?
    @NSManaged public var question: Question?

}
