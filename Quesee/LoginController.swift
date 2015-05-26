//
//  LoginController.swift
//  Quesee
//
//  Created by Adbeel on 5/19/15.
//  Copyright (c) 2015 Quesee Inc. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        emailInput.text = "user_100@quesee.co"
        passwordInput.text = "11111111"
        
    }
    
    @IBAction func login(sender: AnyObject) {
        if emailInput.text == "" || passwordInput.text == "" {
            var alert = UIAlertController(title: "Quesee", message: "Please enter email and password", preferredStyle: UIAlertControllerStyle.Alert)
            let axtion = UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(axtion)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            account.login(emailInput.text, password: passwordInput.text)
        }
    }
    
    @IBAction func signUp(sender: AnyObject) {
    }
}