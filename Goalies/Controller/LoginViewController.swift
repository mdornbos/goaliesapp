//
//  LoginViewController.swift
//  Goalies
//
//  Created by Matt Dornbos on 1/3/25.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    let db = Firestore.firestore()
    var gameplayStatsManager = GameplayStatsManager()
    
    var outputStats: GameplayStatsModel = GameplayStatsModel(guess1: 0, guess2: 0, guess3: 0, guess4: 0, incorrect: 0, questions: 0, streak: 0, docID: "", maxStreak: 0)
    
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!

    
    @IBOutlet weak var loginFail: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gameplayStatsManager.delegate = self
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
                    
                    self.gameplayStatsManager.favorites()
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        
                        self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                    })
                      
                    
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.loginSegue {
            let gameVC: GameViewController = segue.destination as! GameViewController
            gameVC.outputStats = self.outputStats
        }
    }
}


//MARK: - GameplayStatsManager

extension LoginViewController: GameplayStatsManagerDelegate{
    func didRetrieveStats(_ gameplayStatsManager: GameplayStatsManager, outputStats: GameplayStatsModel) {
        
        self.outputStats = outputStats

    }
    
}

