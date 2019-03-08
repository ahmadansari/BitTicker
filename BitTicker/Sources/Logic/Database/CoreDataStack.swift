//
//  CoreDataStack.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 10/22/18.
//  Copyright © 2018 Ahmad Ansari. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    
    static let defaultStack = CoreDataStack()
    // Make init private for singleton
    
    private override init() {
        
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.XCDataModelFile)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                SLog.error("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Main MOC
    lazy var managedObjectContext: NSManagedObjectContext = {
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        return persistentContainer.viewContext
    }()
    
    //New Background MOC
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    // MARK: - Core Data Saving support
    class func saveContext(managedObjectContext: NSManagedObjectContext) {
        managedObjectContext.perform {
            if (managedObjectContext.hasChanges) {
                do {
                    try managedObjectContext.save()
                } catch let exp {
                    SLog.error("MOC Save Error: \(exp)")
                    managedObjectContext.undo()
                }
            }
        }
    }
}
