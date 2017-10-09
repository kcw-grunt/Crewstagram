//
//  CrewImage+CoreDataProperties.swift
//  Crewstagram
//
//  Created by Kerry Washington on 10/6/17.
//  Copyright © 2017 Grunt Software. All rights reserved.
//
//

import Foundation
import CoreData


extension CrewImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrewImage> {
        return NSFetchRequest<CrewImage>(entityName: "CrewImage")
    }

    @NSManaged public var favorites: Int16
    @NSManaged public var imageUrlString: String?
    @NSManaged public var uuid: String?
    @NSManaged public var comments: NSSet?
    @NSManaged public var imageData: NSData?
}

// MARK: Generated accessors for comments
extension CrewImage {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}
