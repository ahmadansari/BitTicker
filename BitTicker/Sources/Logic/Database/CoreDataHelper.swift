//
//  CoreDataHelper.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 10/22/18.
//  Copyright © 2018 Ahmad Ansari. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper: NSObject {
    
    static let defaultHelper = CoreDataHelper()
    // Make init private for singleton
    private override init() {
        
    }
    
    class func turnObjectIntoFault(objectID: NSManagedObjectID,
                                   context: NSManagedObjectContext
        ) {
        //Turn Fault On Core Data Object, resulting in fetching the latest state of the object from persistent store on next access
        do {
            let objcet = try context.existingObject(with: objectID)
            context.refresh(objcet, mergeChanges: false)
        } catch {
            SLog.error(error)
        }
    }
    
    class func countForEntity(entityName: String,
                              predicate: NSPredicate?,
                              context: NSManagedObjectContext)
        -> NSInteger {
            var entityCount = 0
            do {
                let request = NSFetchRequest<NSFetchRequestResult>()
                let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
                request.entity = entity
                request.includesSubentities = false
                request.predicate = predicate
                entityCount = try context.count(for: request)
            } catch {
                SLog.error(error)
            }
            return entityCount
    } 
}
