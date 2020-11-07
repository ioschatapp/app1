//
//  User+CoreDataProperties.swift
//  medical
//
//  Created by Y YM on 2020/11/7.
//  Copyright © 2020 edu. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?

}
