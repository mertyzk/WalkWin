//
//  User.swift
//  Walk&Win
//
//  Created by Macbook Air on 26.08.2022.
//

import Foundation

var currentUser: User?

struct User {
    var nickName: String?
    var userID: String?
    var emailAdress: String?
    var totalDistance: Double?
    
    init(userData: [String : Any]) {
        self.nickName = userData["nickName"] as? String ?? "0x0x0x0"
        self.userID = userData["userID"] as? String ?? "0x0x0x0"
        self.emailAdress = userData["emailAdress"] as? String ?? "0x0x0x0"
        self.totalDistance = userData["totalDistance"] as? Double ?? 000
    }
    
    init(){
        
    }
}
