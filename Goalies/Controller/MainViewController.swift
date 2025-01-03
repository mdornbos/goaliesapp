//
//  MainViewController.swift
//  Goalies
//
//  Created by Matt Dornbos on 1/3/25.
//

import UIKit

class MainViewController: UIViewController {

    var outputGoals: [GoalModel] = []
    var goalManager = GoalManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        goalManager.delegate = self
    }
    
    
    @IBAction func viewGoals(_ sender: UIButton) {
        
        self.goalManager.goals()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            self.performSegue(withIdentifier: Constants.showGoalsSegue, sender: self)
        })
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showGoalsSegue {
            let showVC: ShowGoalViewController = segue.destination as! ShowGoalViewController
            
            showVC.goals = self.outputGoals
        }
    }

}


//MARK: - GoalManager

extension MainViewController: GoalManagerDelegate {
    
    func didRetrieveGoals(_ goalManager: GoalManager, outputGoals: [GoalModel]) {
        
        self.outputGoals = outputGoals
    }
}


