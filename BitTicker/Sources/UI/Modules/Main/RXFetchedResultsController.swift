//
//  RXFetchedResultsController.swift
//
//
//  Created by Ahmad Ansari on 07/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class RXFetchedResultsController: NSObject, NSFetchedResultsControllerDelegate {
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    fileprivate var managedObjectContext: NSManagedObjectContext!
    
    //Block Operations For CollectionView
    var blockOperations: [BlockOperation]!
    
    // MARK: Publish Events
    let loadContents = PublishSubject<Void>()
    let willChangeContent = PublishSubject<Void>()
    var itemChange = PublishSubject<[String: Any]>()
    var sectionChange = PublishSubject<[String: Any]>()
    var didChangeContent = PublishSubject<Void>()
    
    // MARK: Methods
    init(context managedObjectContext: NSManagedObjectContext) {
        super.init()
        self.managedObjectContext = managedObjectContext
        self.initializeFetchedResultsController(Ticker.self, sortDescriptor: "currencyPairId")
    }
    
    //var variable: Variable
    func initializeFetchedResultsController(_ type: NSManagedObject.Type, sortDescriptor key: String) {
        let request = NSFetchRequest<NSManagedObject>(entityName: type.entity().name!)
        let nameSort = NSSortDescriptor(key: key, ascending: true)
        request.sortDescriptors = [nameSort]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController = frc as? NSFetchedResultsController<NSFetchRequestResult>
        fetchedResultsController.delegate = self
    }
    
    func performFetch() {
        self.managedObjectContext.perform {
            self.fetchedResultsController.delegate = self
            do {
                try self.fetchedResultsController.performFetch()
                self.loadContents.onNext(())
            } catch {
                fatalError("Failed to initialize FetchedResultsController: \(error)")
            }
        }
    }
    
    // MARK: NSFetchedResultsController Delegates
    internal func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        SLog.debug("change start")
        blockOperations = [BlockOperation]()
        willChangeContent.onNext(())
    }
    
    internal func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        SLog.debug("section change")
        sectionChange.onNext(
            ["sectionIndex": sectionIndex, "type": type]
        )
    }
    
    internal func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        SLog.debug("object change")
        itemChange.onNext(
            ["indexPath": indexPath as Any, "type": type, "newIndexPath": newIndexPath as Any]
        )
    }
    
    internal func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        SLog.debug("change end")
        didChangeContent.onNext(())
    }
}

extension RXFetchedResultsController: Disposable {
    public func dispose() {
        fetchedResultsController.delegate = nil
    }
}

// MARK: - FRC Data Binding
extension RXFetchedResultsController {
    //Subscribe for TableView
    func subscribe(forTableView tableView: UITableView!) {
        //Load Contents
        self.loadContents.subscribe(onNext: { () in
            print("RX: contents loaded")
            tableView.reloadData()
        }).disposed(by: disposeBag)
        
        //Will Change Contents
        self.willChangeContent
            .subscribe(onNext: { () in
                print("RX: will chnage content")
                tableView.beginUpdates()
            }).disposed(by: disposeBag)
        
        //Item Change
        self.itemChange
            .subscribe(onNext: { item in
                print("RX: Item change")
                
                let indexPath = item["indexPath"] as? IndexPath
                let type = item["type"] as! NSFetchedResultsChangeType
                let newIndexPath = item["newIndexPath"] as? IndexPath
                
                switch type {
                case .insert:
                    tableView.insertRows(at: [newIndexPath!], with: .fade)
                case .delete:
                    tableView.deleteRows(at: [indexPath!], with: .fade)
                case .update:
                    tableView.reloadRows(at: [indexPath!], with: .fade)
                case .move:
                    tableView.moveRow(at: indexPath!, to: newIndexPath!)
                }
            }).disposed(by: disposeBag)
        
        //Section Change
        self.sectionChange
            .subscribe(onNext: { item in
                print("RX: Section Change")
                let sectionIndex = item["sectionIndex"] as! Int
                let type = item["type"] as! NSFetchedResultsChangeType
                
                switch type {
                case .insert:
                    tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
                case .delete:
                    tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
                case .move:
                    break
                case .update:
                    break
                }
            }).disposed(by: disposeBag)
        
        self.didChangeContent
            .subscribe(onNext: { () in
                tableView.endUpdates()
            }).disposed(by: disposeBag)
        
    }
    
    //Subscribe for CollectionView
    func subscribe(forCollectionView collectionView: UICollectionView!) {
        //Load Contents
        self.loadContents.subscribe(onNext: { () in
            print("RX: contents loaded")
            collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        //Will Change Contents
        self.willChangeContent
            .subscribe(onNext: { () in
                print("RX: will chnage content")
                
            }).disposed(by: disposeBag)
        
        //Item Change
        self.itemChange
            .subscribe(onNext: { item in
                print("RX: Item change")
                
                let indexPath = item["indexPath"] as? IndexPath
                let type = item["type"] as! NSFetchedResultsChangeType
                let newIndexPath = item["newIndexPath"] as? IndexPath
                
                switch type {
                case .insert:
                    self.blockOperations.append(
                        BlockOperation(block: {
                            collectionView.insertItems(at: [newIndexPath!])
                        })
                    )
                case .delete:
                    self.blockOperations.append(
                        BlockOperation(block: {
                            collectionView.deleteItems(at: [indexPath!])
                        })
                    )
                case .update:
                    self.blockOperations.append(
                        BlockOperation(block: {
                            collectionView.reloadItems(at: [indexPath!])
                        })
                    )
                case .move:
                    self.blockOperations.append(
                        BlockOperation(block: {
                            collectionView.moveItem(at: indexPath!, to: newIndexPath!)
                        })
                    )
                }
            }).disposed(by: disposeBag)
        
        //Section Change
        self.sectionChange
            .subscribe(onNext: { item in
                print("RX: Section Change")
                let sectionIndex = item["sectionIndex"] as! Int
                let type = item["type"] as! NSFetchedResultsChangeType
                
                switch type {
                case .insert:
                    self.blockOperations.append(
                        BlockOperation(block: {
                            collectionView.insertSections(IndexSet(integer: sectionIndex))
                        })
                    )
                case .delete:
                    self.blockOperations.append(
                        BlockOperation(block: {
                            collectionView.deleteSections(IndexSet(integer: sectionIndex))
                        })
                    )
                case .move:
                    break
                case .update:
                    self.blockOperations.append(
                        BlockOperation(block: {
                            collectionView.reloadSections(IndexSet(integer: sectionIndex))
                        })
                    )
                    break
                }
            }).disposed(by: disposeBag)
        
        self.didChangeContent
            .subscribe(onNext: { () in
                collectionView.performBatchUpdates({
                    for operation in self.blockOperations {
                        operation.start()
                    }
                }, completion: { [weak self] (_) in
                    self?.blockOperations.removeAll(keepingCapacity: false)
                })
            }).disposed(by: disposeBag)
        
    }
}

// MARK: - FRC Data Source Methods
extension RXFetchedResultsController {
    func numberOfSections() -> NSInteger {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        guard let sections = self.fetchedResultsController.sections else {
            SLog.error("No sections in fetchedResultsController")
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func object(at indexPath: IndexPath) -> AnyObject? {
        
        guard
            let item = self.fetchedResultsController.object(at: indexPath) as? DataTransferProtocol
            else {
                return nil
        }
        //guard item != nil else { return nil }
        //let item = self.fetchedResultsController.object(at: indexPath) as! ViewModelProtocol
        return item.dataTransferObject() as AnyObject
    }
    
    func count() -> NSInteger? {
        return self.fetchedResultsController.fetchedObjects?.count
    }
}
