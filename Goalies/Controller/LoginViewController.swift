//
//  LoginViewController.swift
//  Goalies
//
//  Created by Matt Dornbos on 1/3/25.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!

    
    @IBOutlet weak var loginFail: UILabel!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.loginFail.text = ""
        
        self.usernameText.text = defaults.object(forKey: "username") as? String
        self.passwordText.text = defaults.object(forKey: "password") as? String

    }
    

    @IBAction func loginLoginPressed(_ sender: UIButton) {
    
        if let email = usernameText.text, let password = passwordText.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error, !e.localizedDescription.isEmpty {
                    
                    self.loginFail.text = e.localizedDescription
                    self.passwordText.text = ""
                }
                
                else {
                    
                    self.defaults.set(self.usernameText.text, forKey: "username")
                    self.defaults.set(self.passwordText.text, forKey: "password")
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        
                        self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                    })
                      
                    
                }
            }
        }
    }

}


