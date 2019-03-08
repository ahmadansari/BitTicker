//
//  TickerService.swift
//  
//
//  Created by Ahmad Ansari on 07/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import Starscream

class TickerService {
    
    var socket: WebSocket?
    
    init(socketURL url: String) {
        if let url = URL(string: url) {
            socket = WebSocket(url: url)
            socket?.callbackQueue = DispatchQueue.global()
            socket?.delegate = self
            socket?.disableSSLCertValidation = true
        }
    }
    
    func connect() {
        guard socket != nil else {
            return
        }
        socket?.connect()
    }
    
    func isConnected() -> Bool? {
        return socket?.isConnected
    }
    
    func disconnect() {
        socket?.disconnect()
    }
    
    func sendMessage(_ message: String) {
        socket?.write(string: message)
    }
}

extension TickerService: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(error?.localizedDescription ?? "")")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
    }
}
