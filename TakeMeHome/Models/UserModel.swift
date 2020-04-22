//
//  UserModel.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation

struct UserModel {
    let userID:String
    let email:String
    let username:String
    let userAddress: String
    let userZipcode: String
    let userPhotoURL: String?
    let displayName:String
    let guardianName:String?
    let guardianPhone:String?
    let guardianPhotoURL:String?
}

extension UserModel {
    init(_ dictionary: [String:Any]) {
        self.userID = dictionary["userID"] as? String ?? "no userID"
        self.email = dictionary["email"] as? String ?? "no email"
        self.username = dictionary["username"] as? String ?? "no username"
        self.userAddress = dictionary["userAddress"] as? String ?? "no user Address"
        self.userZipcode = dictionary["userZipcode"] as? String ?? "no Zipcode"
        self.userPhotoURL = dictionary["photoURL"] as? String ?? "no userPhotoURL"
        self.displayName = dictionary["displayName"] as? String ?? "no display name"
        self.guardianName = dictionary["guardianName"] as? String ?? "no guardian name to decode"
        self.guardianPhone = dictionary["guardianPhone"] as? String ?? "no guardian phone tp decode"
        self.guardianPhotoURL = dictionary["guardianPhotoURL"] as? String ?? "no guardian photoURL"
    }
}
