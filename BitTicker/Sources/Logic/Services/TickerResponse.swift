//
//  TickerResponse.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 07/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

struct TickerResponse: Decodable {
    let id: Int32?
    let nilVal: String?
    let tickerData: TickerData?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        id = try container.decode(Int32.self)
        nilVal = try container.decode(String?.self)
        tickerData = try container.decode(TickerData.self)
    }
}

struct TickerData: Decodable {
    let currencyPairId: Int32
    let lastTradePrice: String
    let lowestAsk: String
    let highestBid: String
    let percentChange: String
    let baseCurrencyVolume: String
    let quoteCurrencyVolume: String
    let isFrozen: Int32
    let highestTradePrice: String
    let lowestTradePrice: String
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        currencyPairId = try container.decode(Int32.self)
        lastTradePrice = try container.decode(String.self)
        lowestAsk = try container.decode(String.self)
        highestBid = try container.decode(String.self)
        percentChange = try container.decode(String.self)
        baseCurrencyVolume = try container.decode(String.self)
        quoteCurrencyVolume = try container.decode(String.self)
        isFrozen = try container.decode(Int32.self)
        highestTradePrice = try container.decode(String.self)
        lowestTradePrice = try container.decode(String.self)
    }
}
