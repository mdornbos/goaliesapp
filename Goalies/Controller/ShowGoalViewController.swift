//
//  ShowGoalViewController.swift
//  Goalies
//
//  Created by Matt Dornbos on 1/3/25.
//

import UIKit

class ShowGoalViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var goals: [GoalModel] = []
    let cellReuseIdentifier = "cell"
    
    var selectedGoal: GoalModel = GoalModel(goalName: "", goalDescription: "", goalType: "", goalAmount: 0, actualAmount: 0, goalComplete: false, email: "", docID: "")
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.goals.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // create a new cell if needed or reuse an old one
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        // set the text from the data model
        let currentGoal = self.goals[indexPath.row]
        cell.textLabel?.text = currentGoal.goalName
        
        return cell
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedGoal = self.goals[indexPath.row]

    }
    
    
    
    @IBAction func showGoal(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: Constants.detailGoalSegue, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.detailGoalSegue {
            let detailVC: DetailGoalViewController = segue.destination as! DetailGoalViewController
            
            detailVC.goal = self.selectedGoal
        }
    }
    

}
