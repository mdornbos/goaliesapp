//
//  DetailGoalViewController.swift
//  Goalies
//
//  Created by Matt Dornbos on 1/3/25.
//

import UIKit

class DetailGoalViewController: UIViewController {
    
    var goal: GoalModel = GoalModel(goalName: "", goalDescription: "", goalType: "", goalAmount: 0, actualAmount: 0, goalComplete: false, email: "", docID: "")
    
    @IBOutlet weak var goalName: UITextField!
    
    @IBOutlet weak var goalDescription: UITextField!
    
    @IBOutlet weak var goalType: UITextField!
    
    @IBOutlet weak var goalAmount: UITextField!
    
    @IBOutlet weak var actualAmount: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.goalName.text = self.goal.goalName
        self.goalDescription.text = self.goal.goalDescription
        self.goalType.text = self.goal.goalType
        self.goalAmount.text = String(self.goal.goalAmount)
        self.actualAmount.text = String(self.goal.actualAmount)
    }


}
