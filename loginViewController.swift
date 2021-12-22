//
//  loginViewController.swift
//  Sleep Learning
//
//  Created by Mani Jahani on 7/18/19.
//  Copyright © 2019 Memory Lab. All rights reserved.
//
//  Description:
//      View controller for the login page.
//

import UIKit
import Firebase

class loginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var IDTextField: UITextField!
    
    @IBAction func signIn(_ sender: UIButton) {
        //  If the email or password fields are empty, display an error message
        guard let email = emailTextField.text, email != "", let password = IDTextField.text, password != "" else {
            let emptyAlert = UIAlertController(title: "Blank response", message: "You must enter both an email and a password.", preferredStyle: .alert)
            emptyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(emptyAlert, animated: true, completion: nil)
            return
        }
        //  Attempt to sign in. If there's an error: display it. If sign in successful:
        //  segue to the instructionsVC.
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            guard let strongSelf = self else {
                return
            }
            if let error = error {
                let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                strongSelf.present(errorAlert, animated: true, completion: nil)
                return
            }
            strongSelf.performSegue(withIdentifier: "signInSuccessful", sender: nil)
        }
    }
}
