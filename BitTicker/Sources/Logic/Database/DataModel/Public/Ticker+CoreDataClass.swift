//
//  Ticker+CoreDataClass.swift
//  
//
//  Created by Ahmad Ansari on 07/03/2019.
//
//

import Foundation
import CoreData

@objc(Ticker)
public class Ticker: NSManagedObject {
    //Entity Name
    static let entityName = Ticker.entity().name ?? "Ticker"
    
    //DTO
    lazy var tickerDTO: TickerDTO = {
        return TickerDTO.init(ticker: self)
    }()
}

extension Ticker: DataTransferProtocol {
    func dataTransferObject() -> Any? {
        return self.tickerDTO
    }
}

//Genre Data Persistence
extension Ticker {
    
    //Saving Genre Object
    @discardableResult class func saveTicker(tickerRespone: TickerResponse,
                                             context: NSManagedObjectContext) -> Ticker? {
        var ticker: Ticker?
        context.performAndWait {
            if let tickerData = tickerRespone.tickerData {
                let pairId = tickerData.currencyPairId
                let request: NSFetchRequest = Ticker.fetchRequest()
                request.predicate = NSPredicate.init(format: "SELF.currencyPairId == %ld", pairId)
                let filteredResults = try? context.fetch(request)
                
                if (filteredResults?.isEmpty == false) {
                    ticker = filteredResults?.first
                } else {
                    ticker = Ticker(context: context)
                }
                ticker?.currencyPairId = pairId
                ticker?.currencyPairName = CurrencyPairIDs(rawValue: pairId)?.description()
                ticker?.lastTradePrice = tickerData.lastTradePrice
                ticker?.lowestAsk = tickerData.lowestAsk
                ticker?.highestBid = tickerData.highestBid
                ticker?.percentChange = tickerData.percentChange
                ticker?.baseCurrencyVolume = tickerData.baseCurrencyVolume
                ticker?.quoteCurrencyVolume = tickerData.quoteCurrencyVolume
                ticker?.isFrozen = tickerData.isFrozen
                ticker?.highestTradePrice = tickerData.highestTradePrice
                ticker?.lowestTradePrice = tickerData.lowestTradePrice
                
                CoreDataStack.saveContext(managedObjectContext: context)
            }
        }
        return ticker
    }
}
