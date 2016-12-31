//
//  SignInViewController.swift
//  MIT DTD
//
//  Created by Dylan Modesitt on 12/31/16.
//  Copyright © 2016 Beta Nu Delta Tau Delta. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController, ErrorPresentable {

    
    // MARK: Variables
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: Methods
    
    @IBAction func signIn(_ sender: Any) {
        guard emailTextField.text != nil && passwordTextField.text != nil else { self.signInMismatch(); return }
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                self.presentErrorView()
            } else {
                UserDefaults.standard.set(true, forKey: "loggedIn")
                self.performSegue(withIdentifier: "showApplication", sender: self)
            }
        }
    }
    
    
    func presentErrorView() {
        Errors.presentErrorView(errorMessage: "Incorrect login for \(emailTextField.text!).")
    }
    
    func signInMismatch() {
        let view = UIAlertView.simpleAlert(withTitle: "Error", andMessage: "Please enter an email and password.")
        view.show()
    }


}
