//
//  CreateGoalViewController.swift
//  Goalies
//
//  Created by Matt Dornbos on 1/3/25.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateGoalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let db = Firestore.firestore()
    
    var pickers: [String] = ["Books", "Dollars", "Miles", "Workouts", "Movies", "Games", "Pounds", "Custom"]
    
    var pickedType: String = ""
    
    let defaults = UserDefaults.standard
    
    var email: String = ""
    
    var goalModel: GoalModel = GoalModel(goalName: "", goalDescription: "", goalType: "", goalAmount: 0, actualAmount: 0, goalComplete: false, email: "", docID: "")
    
    @IBOutlet weak var goalDescription: UITextField!
    
    @IBOutlet weak var goalName: UITextField!
    
    @IBOutlet weak var goalType: UIPickerView!
    
    @IBOutlet weak var goalAmount: UITextField!
    
    
    @IBOutlet weak var errorField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.goalType.delegate = self
        self.goalType.dataSource = self
        self.pickedType = self.pickers[0]
        self.errorField.text = ""
        
        self.email = defaults.object(forKey: "username") as? String ?? "Unknown"
        
    }
    
    @IBAction func createGoal(_ sender: UIButton) {
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.pickers.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.pickers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.pickedType = self.pickers[row]
    }
    
    
    @IBAction func goalSubmit(_ sender: UIButton) {
        
        if self.goalName.text == nil {
            
            self.errorField.text = "Please Add a Goal Name!"
            self.errorField.textColor = UIColor.systemRed
        }
        else if self.goalDescription.text == nil {
            
            self.errorField.text = "Please Add a Goal Description!"
            self.errorField.textColor = UIColor.systemRed
        }

        else if self.goalAmount.text == nil {
            
            self.errorField.text = "Please Add a Goal Amount!"
            self.errorField.textColor = UIColor.systemRed
        }
        
        else if Int(self.goalAmount.text!) == nil {
            
            self.errorField.text = "Please Submit Goal Amount as Integer"
            self.errorField.textColor = UIColor.systemRed
            
           }
        
        else {
            
            self.goalModel = GoalModel(goalName: self.goalName.text!, goalDescription: self.goalDescription.text!, goalType: self.pickedType, goalAmount: Int(self.goalAmount.text!) ?? 0, actualAmount: 0, goalComplete: false, email: self.email, docID: "")
            
            self.sendToFirebase(goal: self.goalModel)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                
                self.errorField.text = "Goal Saved!"
                self.errorField.textColor = UIColor.systemGreen
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    
                    self.performSegue(withIdentifier: Constants.goalCreatedSegue, sender: self)
                })

            })
 
        }

    }
    
    func sendToFirebase(goal: GoalModel) {
        
        if let user = Auth.auth().currentUser?.email {
            
            let goalsDB = self.db.collection(Constants.Fstore.goalCollection)
            let email = user
            let docID = goal.docID
            
            if docID == "" {
                do {
                    let ref = goalsDB.addDocument(data: [
                        Constants.Fstore.goalName: goal.goalName,
                        Constants.Fstore.goalDescription: goal.goalDescription,
                        Constants.Fstore.goalType: goal.goalType,
                        Constants.Fstore.goalAmount: goal.goalAmount,
                        Constants.Fstore.goalComplete: goal.goalComplete,
                        Constants.Fstore.actualAmount: goal.actualAmount,
                        Constants.Fstore.email: email,
                        
                        
                    ])
                    self.goalModel.docID = ref.documentID
                }
            }
        }
 
    }
}
