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
    
    private let db = Firestore.firestore()
    
    public func createDatabaseUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let email = authDataResult.user.email else {
            return
        }
        db.collection(DatabaseService.usersCollection)
            .document(authDataResult.user.uid)
            .setData(["email" : email,
                      "createdDate": Timestamp(date: Date()),
                      "userId": authDataResult.user.uid]) { (error) in
                        
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(true))
                        }
        }
    }
    
    func updateDatabaseUser(displayName: String,
                            photoURL: String,
                            name: String,
                            address: String,
                            zipcode: String,
                            coordinates: String,
                            guardianName: String,
                            guardianPhone: String,
                            completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.usersCollection)
            .document(user.uid).updateData(["photoURL" : photoURL,
                                            "displayName" : displayName]) { (error) in
                                                if let error = error {
                                                    completion(.failure(error))
                                                } else {
                                                    completion(.success(true))
                                                }
        }
    }
    
    
}
