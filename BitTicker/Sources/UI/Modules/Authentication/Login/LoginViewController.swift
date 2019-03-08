//
//  LoginViewController.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 08/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManager

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.text = "user1"
        passwordField.text = "12345"
    }
    
    @IBAction func onTapLoginButton(_ sender: UIButton) {
        
        guard (usernameField.text?.count)! > 0 else {
            Utility.defaultUtility.displayErrorAlert(messageText: Message.emptyUsername.rawValue, delegate: self)
            return
        }
        
        guard (passwordField.text?.count)! > 0 else {
            Utility.defaultUtility.displayErrorAlert(messageText: Message.emptyPassword.rawValue, delegate: self)
            return
        }
        
        let user = User(usernameField.text!, passwordField.text!)
        let result = AuthHandler.shared.checkValidity(forUser: user)
        self.view.endEditing(true)
        if result.status == true {
            MainViewController.show()
        } else {
            Utility.defaultUtility.displayErrorAlert(messageText: result.error?.rawValue ?? "", delegate: self)
        }
    }
}
