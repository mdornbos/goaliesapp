//
//  GoalManager.swift
//  Goalies
//
//  Created by Matt Dornbos on 1/3/25.
//

import Foundation
import Firebase
import FirebaseAuth

protocol GoalManagerDelegate {
    
    func didRetrieveGoals(_ goalManager: GoalManager, outputGoals: [GoalModel])
}

class GoalManager {
    
    var delegate: GoalManagerDelegate?
    let db = Firestore.firestore()
    var goalList: [GoalModel] = []
    
    func goals() {
        
        self.goalList = []
        
        if let user = Auth.auth().currentUser?.email{
            
            let goalsDB = self.db.collection(Constants.Fstore.goalCollection)
            
            let query = goalsDB.whereField(Constants.Fstore.email, isEqualTo: user)
            
            query.getDocuments{(querySnapshot, error) in
                
                if error == nil {
                    
                    if let snapshotDocument = querySnapshot?.documents {
                        
                        if snapshotDocument.count > 0 {
                            for pick in snapshotDocument {
                                
                                let documentID = pick.documentID
                                
                                let name = pick.data()[Constants.Fstore.goalName] as! String
                                let description = pick.data()[Constants.Fstore.goalDescription] as! String
                                let type = pick.data()[Constants.Fstore.goalType] as! String
                                let amount = pick.data()[Constants.Fstore.goalAmount] as! Int
                                let actual = pick.data()[Constants.Fstore.actualAmount] as! Int
                                let complete = pick.data()[Constants.Fstore.goalComplete] as! Bool

                                
                                let goal = GoalModel(goalName: name, goalDescription: description, goalType: type, goalAmount: amount, actualAmount: actual, goalComplete: complete, email: user, docID: documentID)
                                
                                self.goalList.append(goal)
                                
                                self.delegate?.didRetrieveGoals(self, outputGoals: self.goalList)
                                }
                            }
                        }
                        else {
                            print("error retrieving data")
                        }
                    }
                }
            }
            
            
        }
    }






