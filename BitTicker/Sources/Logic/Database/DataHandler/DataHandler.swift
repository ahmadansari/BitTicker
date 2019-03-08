//
//  DataHandler.swift
//  iOSArchitectures
//
//  Created by Ahmad Ansari on 10/22/18.
//  Copyright © 2018 Ahmad Ansari. All rights reserved.
//

import Foundation

class DataHandler: NSObject {
    
    // Make init private for singleton
    private override init() { }
    
    // MARK: Default Handler
    static let defaultHandler = DataHandler()
    let backgroundContext = CoreDataStack.defaultStack.newBackgroundContext()
    
    // MARK: Local Variables
    let tickerService = TickerService(socketURL: Constants.channelURL)
    
    func subscribeTickers(completion:@escaping (_ error: Bool) -> Void) {
        tickerService.socket?.onConnect = { [weak self] in
            self?.tickerService.sendMessage("{\"command\":\"subscribe\",\"channel\": 1002}")
            completion(true)
        }
        
        tickerService.socket?.onDisconnect = { error in
            completion(false)
        }
            
        tickerService.socket?.onText  = { text in
            if let jsonData = text.data(using: .utf8) {
                if let tickerResponse = try? JSONDecoder().decode(TickerResponse.self, from: jsonData) {
                    Ticker.saveTicker(tickerRespone: tickerResponse, context: self.backgroundContext)
                }
            }
        }
        tickerService.connect()
    }
}
