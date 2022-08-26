//
//  User.swift
//  Walk&Win
//
//  Created by Macbook Air on 26.08.2022.
//

import Foundation

var currentUser: User?

struct User {
    let nickName: String
    let userID: String
    let emailAdress: String
    init(userData: [String : Any]) {
        self.nickName = userData["UserName"] as? String ?? "0x0x0x0"
        self.userID = userData["UserID"] as? String ?? "0x0x0x0"
        self.emailAdress = userData["EmailAdress"] as? String ?? "0x0x0x0"
    }
}
