//
//  AuthHandler.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 08/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

class AuthHandler: NSObject {
    
    static let shared = AuthHandler()
    // Make init private for singleton
    
    private override init() {
    }
    
    func checkValidity(forUser user: User) -> (status: Bool, error: Message?) {
        let defaults = UserDefaults.standard
        if let value = defaults.value(forKey: user.username) as? String {
            if value == user.password {
                return (true, nil)
            }
        }
        return (false, Message.invalidCredentials)
    }
    
    func saveUser(_ user: User) -> (status: Bool, error: Message?) {
        let defaults = UserDefaults.standard
        if let _ = defaults.value(forKey: user.username) as? String {
            return (false, Message.alreadyExists)
        } else {
            defaults.set(user.password, forKey: user.username)
            if defaults.synchronize() == true {
                return (true, nil)
            } else {
                return (false, Message.general)
            }
        }
    }
}
