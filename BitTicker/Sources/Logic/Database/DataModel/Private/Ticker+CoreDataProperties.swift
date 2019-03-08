//
//  Ticker+CoreDataProperties.swift
//  
//
//  Created by Ahmad Ansari on 07/03/2019.
//
//

import Foundation
import CoreData

extension Ticker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ticker> {
        return NSFetchRequest<Ticker>(entityName: "Ticker")
    }

    @NSManaged public var baseCurrencyVolume: String?
    @NSManaged public var currencyPairId: Int32
    @NSManaged public var currencyPairName: String?
    @NSManaged public var highestBid: String?
    @NSManaged public var highestTradePrice: String?
    @NSManaged public var isFrozen: Int32
    @NSManaged public var lastTradePrice: String?
    @NSManaged public var lowestAsk: String?
    @NSManaged public var lowestTradePrice: String?
    @NSManaged public var percentChange: String?
    @NSManaged public var quoteCurrencyVolume: String?

}
