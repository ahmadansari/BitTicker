//
//  SignUpViewController.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 08/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManager

class SignUpViewController: UIViewController {
 
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTapSignUpButton(_ sender: UIButton) {
        
        guard (usernameField.text?.count)! > 0 else {
            Utility.defaultUtility.displayErrorAlert(messageText: Message.emptyUsername.rawValue, delegate: self)
            return
        }
        
        guard (passwordField.text?.count)! > 0 else {
            Utility.defaultUtility.displayErrorAlert(messageText: Message.emptyPassword.rawValue, delegate: self)
            return
        }
        
        guard passwordField.text == confirmPasswordField.text else {
            Utility.defaultUtility.displayErrorAlert(messageText: Message.passwordMismatch.rawValue, delegate: self)
            return
        }
        
        let user = User(usernameField.text!, passwordField.text!)
        let result = AuthHandler.shared.saveUser(user)
        if result.status == true {
            //User Created
            Utility.defaultUtility.displayAlert(title: "BitTicker",
                                                messageText: Message.signUpSuccess.rawValue,
                                                delegate: self) { [weak self] in
                                                    self?.view.endEditing(true)
                                                    MainViewController.show()
            }
        } else {
            Utility.defaultUtility.displayErrorAlert(messageText: result.error?.rawValue ?? "", delegate: self)
        }

    }
    
    @IBAction func onTapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
