//
//  RegisterViewController.swift
//  Goalies
//
//  Created by Matt Dornbos on 1/3/25.
//


import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    
    
    @IBOutlet weak var registerPassword: UITextField!
    
    
    @IBOutlet weak var registerUsername: UITextField!
    
    @IBOutlet weak var invalidRegister: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.invalidRegister.text = ""
    }
    

    @IBAction func registerPressed(_ sender: UIButton) {
    
    if let email = registerUsername.text, let password = registerPassword.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error, !e.localizedDescription.isEmpty {
                    
                    self.invalidRegister.text = e.localizedDescription
                    self.registerUsername.text = ""
                    self.registerPassword.text = ""
                }
                else {
                    
                    self.performSegue(withIdentifier: Constants.registrationSegue, sender: self)
                }
            }
            
        }

    }
    
}

