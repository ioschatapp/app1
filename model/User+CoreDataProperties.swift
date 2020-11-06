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
    @NSManaged public var saveTopics: NSOrderedSet?

}

// MARK: Generated accessors for saveTopics
extension User {

    @objc(insertObject:inSaveTopicsAtIndex:)
    @NSManaged public func insertIntoSaveTopics(_ value: SaveTopics, at idx: Int)

    @objc(removeObjectFromSaveTopicsAtIndex:)
    @NSManaged public func removeFromSaveTopics(at idx: Int)

    @objc(insertSaveTopics:atIndexes:)
    @NSManaged public func insertIntoSaveTopics(_ values: [SaveTopics], at indexes: NSIndexSet)

    @objc(removeSaveTopicsAtIndexes:)
    @NSManaged public func removeFromSaveTopics(at indexes: NSIndexSet)

    @objc(replaceObjectInSaveTopicsAtIndex:withObject:)
    @NSManaged public func replaceSaveTopics(at idx: Int, with value: SaveTopics)

    @objc(replaceSaveTopicsAtIndexes:withSaveTopics:)
    @NSManaged public func replaceSaveTopics(at indexes: NSIndexSet, with values: [SaveTopics])

    @objc(addSaveTopicsObject:)
    @NSManaged public func addToSaveTopics(_ value: SaveTopics)

    @objc(removeSaveTopicsObject:)
    @NSManaged public func removeFromSaveTopics(_ value: SaveTopics)

    @objc(addSaveTopics:)
    @NSManaged public func addToSaveTopics(_ values: NSOrderedSet)

    @objc(removeSaveTopics:)
    @NSManaged public func removeFromSaveTopics(_ values: NSOrderedSet)

}
