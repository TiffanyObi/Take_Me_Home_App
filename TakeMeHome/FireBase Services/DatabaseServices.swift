//
//  DatabaseServices.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
    
    static let usersCollection = "users"
    static let shared = DatabaseService()
    private let db = Firestore.firestore()
    public var hasGardian = false
    public var email = ""
    public var password = ""
    public var pin = ""
    
    public func createDatabaseUser(hasGuardian: String, authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let email = authDataResult.user.email else {
            return
        }
        db.collection(DatabaseService.usersCollection)
            .document(authDataResult.user.uid)
            .setData(["email" : email,
                      "createdDate": Timestamp(date: Date()),
                      "userId": authDataResult.user.uid,
                      "hasGuaridan":hasGuardian,
                      "pin": pin]) { (error) in
                        
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(true))
                        }
        }
    }
    
    func updateDatabaseUser(pin: String,
                            name: String,
                            address: String,
                            zipcode: String,
                            coordinates: String,
                            guardianName: String,
                            guardianPhone: String,
                            completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.usersCollection)
            .document(user.uid).updateData(["name": name]) { (error) in
                                                if let error = error {
                                                    completion(.failure(error))
                                                } else {
                                                    completion(.success(true))
                                                }
        }
    }
    
    func signoutButtonPressed() {
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController(storyboardName: "Login_Selection_AppState", viewControllerID: "LoginViewController")
        } catch {
            fatalError("Couldn't sign out")
        }
    }
    
    
}
