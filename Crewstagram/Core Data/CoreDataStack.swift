//
//  CoreDataStack.swift
//  Crewstagram
//
//  Created by Kerry Washington on 10/7/17.
//  Copyright © 2017 Grunt Software. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    let persistentContainer = NSPersistentContainer(name: "Crewstagram")
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy private(set) var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func setup(completion: @escaping ((_ success: Bool) -> Void)) {
        persistentContainer.loadPersistentStores() {storeDescription, error in
            print("storeDescription: \(storeDescription)")
            if let error = error {
                print("loadContainer error: \(error)")
                completion(false)
            } else {
                print(self.persistentContainer.viewContext.automaticallyMergesChangesFromParent)
                self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
                completion(true)
            }
        }
    }
}
