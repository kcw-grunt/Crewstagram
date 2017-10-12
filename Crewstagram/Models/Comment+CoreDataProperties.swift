//
//  Comment+CoreDataProperties.swift
//  Crewstagram
//
//  Created by Kerry Washington on 10/6/17.
//  Copyright © 2017 Grunt Software. All rights reserved.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var body: String?
    @NSManaged public var username: String?
}
