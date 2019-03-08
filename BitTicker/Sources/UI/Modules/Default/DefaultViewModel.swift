//
//  DefaultViewModel.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 07/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import CoreData

typealias VoidBlock = () -> Void

class DefaultViewModel {
    //Model Layer
    fileprivate var dataHandler = DataHandler.defaultHandler
    fileprivate var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: RXFetchedResultsController!
}

extension DefaultViewModel {
    
    // MARK: - Configuration
    func configure() {
        managedObjectContext = CoreDataStack.defaultStack.managedObjectContext
        fetchedResultsController = RXFetchedResultsController(context: managedObjectContext)
    }
    
    // MARK: - Data Methods
    func loadTickers(completion: @escaping VoidBlock) {
        dataHandler.subscribeTickers { (_) in
            completion()
        }        
    }    
}
