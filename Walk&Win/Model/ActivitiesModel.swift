//
//  Activities.swift
//  Walk&Win
//
//  Created by Macbook Air on 3.09.2022.
//

import Foundation
import FirebaseFirestore

struct ActivitiesModel {
    var ActivityId: String?
    var ActivityName: String?
    var ActivityDistance: Double?
    var UserId: String?
    var ActivityTime: Int?
    var ActivityDate: Timestamp?
    var ActivityVelocity: Double?
    var ActivityPoints: [GeoPoint]?
    
    init(activityData: [String : Any]) {
        self.ActivityId = activityData["ActivityId"] as? String ?? "0x0x0x0"
        self.ActivityName = activityData["ActivityName"] as? String ?? "0x0x0x0"
        self.ActivityDistance = activityData["ActivityDistance"] as? Double ?? 0.0
        self.UserId = activityData["UserId"] as? String ?? "0x0x0x0"
        self.ActivityDate = activityData["ActivityDate"] as? Timestamp
        self.ActivityTime = activityData["ActivityTime"] as? Int ?? 0
        self.ActivityVelocity = activityData["ActivityVelocity"] as? Double ?? 0.0
        self.ActivityPoints = activityData["ActivityPoints"] as? [GeoPoint]
    }
    
    init() {
    }
    
}





