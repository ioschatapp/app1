//
//  Question+CoreDataProperties.swift
//  medical
//
//  Created by Y YM on 2020/11/5.
//  Copyright © 2020 edu. All rights reserved.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var community: Bool
    @NSManaged public var question: String?
    @NSManaged public var topic: Topic?

}
