//
//  Activities.swift
//  Walk&Win
//
//  Created by Macbook Air on 3.09.2022.
//

import Foundation
import FirebaseFirestore

struct Activities {
    var ActivityId: String?
    var ActivityName: String?
    var ActivityDistance: Double?
    var UserId: String?
    var ActivityDate: Timestamp?
    
    init(activityData: [String : Any]) {
        self.ActivityId = activityData["ActivityId"] as? String ?? "0x0x0x0"
        self.ActivityName = activityData["ActivityName"] as? String ?? "0x0x0x0"
        self.ActivityDistance = activityData["ActivityDistance"] as? Double ?? 000
        self.UserId = activityData["UserId"] as? String ?? "0x0x0x0"
        self.ActivityDate = activityData["ActivityDate"] as? Timestamp
    }
    
    init() {
    }
    
}





