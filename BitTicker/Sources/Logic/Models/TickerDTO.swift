//
//  TickerDTO.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 07/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import Localize_Swift

class TickerDTO: NSObject {
    
    private weak var ticker: Ticker?
    
    init(ticker: Ticker) {
        super.init()
        self.ticker = ticker
    }
    
    //Pair Id, Name
    func currencyPairName() -> String? {
        return ticker?.currencyPairName
    }
    
    func currencyPairId() -> Int32? {
        return ticker?.currencyPairId
    }
    
    //Trade Prices
    func lastTradePrice() -> String? {
        return ticker?.lastTradePrice
    }
    
    func lowestTradePrice() -> String? {
        return ticker?.lowestTradePrice
    }
    
    func highestTradePrice() -> String? {
        return ticker?.highestTradePrice
    }
    
    //Biding Values
    func highestBid() -> String? {
        return ticker?.highestBid
    }
    
    func lowestAsk() -> String? {
        return ticker?.lowestAsk
    }
    
    func isFrozen() -> Int32? {
        return ticker?.isFrozen
    }
    
    //Currency Volume
    func quoteCurrencyVolume() -> String? {
        return ticker?.quoteCurrencyVolume
    }
    
    func baseCurrencyVolume() -> String? {
        return ticker?.baseCurrencyVolume
    }
    
    //Percent Change
    func percentChangeValue() -> String? {
        var percentValue: String?
        if let change = ticker?.percentChange {
            if let value = Double(change)?.roundToDecimal(3) {
                percentValue = "\(String(value)) %"
            }
        }
        return percentValue
    }
    
    func isLastTradePricePositive(forValue priceValue: Double) -> Bool {
        var result = false
        if let tradePrice = ticker?.lastTradePrice {
            if let value = Double(tradePrice) {
                if value > priceValue {
                    result = true
                }
            }
        }
        return result
    }
    
    func isChangePositive() -> Bool {
        var result = false
        if let change = ticker?.percentChange {
            if let value = Double(change) {
                if value > 0 {
                    result = true
                }
            }
        }
        return result
    }
}
