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
    let pin:String
    let hasGuaridan: String
    let email:String
    let username:String
    let userPhoneNumber:String
    let userAddress: String
    let userZipcode: String
    let userPhotoURL: String?
    let displayName:String
    let guardianName:String?
    let guardianAddress:String?
    let guardianZipcode:String
    let guardianPhone:String?
    let guardianPhotoURL:String?
}

extension UserModel {
    init(_ dictionary: [String:Any]) {
        self.userID = dictionary["userID"] as? String ?? "no userID"
        self.pin = dictionary["pin"] as? String ?? "no pin"
        self.hasGuaridan = dictionary["hasGuaridan"] as? String ?? "no hasGuaridan"
        self.email = dictionary["email"] as? String ?? "no email"
        self.username = dictionary["username"] as? String ?? ""
        self.userPhoneNumber = dictionary["userPhone"] as? String ?? ""
        self.userAddress = dictionary["userAddress"] as? String ?? ""
        self.userZipcode = dictionary["userZipcode"] as? String ?? ""
        self.userPhotoURL = dictionary["photoURL"] as? String ?? "no userPhotoURL"
        self.displayName = dictionary["displayName"] as? String ?? ""
        self.guardianName = dictionary["guardianName"] as? String ?? ""
        self.guardianZipcode = dictionary["guardianZipcode"] as? String ?? ""
        self.guardianAddress = dictionary["guardianAddress"] as? String ?? ""
        self.guardianPhone = dictionary["guardianPhone"] as? String ?? ""
        self.guardianPhotoURL = dictionary["guardianPhotoURL"] as? String ?? "no guardian photoURL"
    }
}


struct SimulateNotification{
    
    var totalSeconds: Int
    
    var seconds : Int {
        return totalSeconds % 60
    }
}




