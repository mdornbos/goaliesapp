//
//  Constants.swift
//  Goalies
//
//  Created by Matt Dornbos on 1/3/25.
//

import Foundation

struct Constants {
    
    // Segues
    static let registrationSegue: String = "registerToLoginSegue"
    static let loginSegue: String = "loginSuccessSegue"
    static let goalCreatedSegue: String = "submittedGoalSegue"
    static let showGoalsSegue: String = "showGoalsSegue"
    static let detailGoalSegue: String = "detailGoalSegue"
    
    // Firebase
    struct Fstore {
        static let goalCollection: String = "goals"
        
        static let goalName: String = "name"
        static let goalDescription: String = "description"
        static let goalType: String = "type"
        static let goalAmount: String = "amount"
        static let actualAmount: String = "actual"
        static let goalComplete: String = "complete"
        static let email: String = "email"
    }
}
