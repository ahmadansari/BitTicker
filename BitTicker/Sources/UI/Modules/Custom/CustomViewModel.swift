//
//  CustomViewModel.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 08/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import CoreData

class CustomViewModel {
    //Model Layer
    fileprivate var dataHandler = DataHandler.defaultHandler
    fileprivate var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: RXFetchedResultsController!    
}

extension CustomViewModel {
    
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
