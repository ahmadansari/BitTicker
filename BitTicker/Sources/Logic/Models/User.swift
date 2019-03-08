//
//  UserDTO.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 08/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

class User {
    var username: String
    var password: String
    
    init(_ name: String, _ pass: String) {
        username = name
        password = pass
    }
    
    func isValid() -> Bool {
        return AuthHandler.shared.checkValidity(forUser: self).status
    }
}
