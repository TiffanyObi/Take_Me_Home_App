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
    
    
    public func createDatabaseUser(hasGuardian: String,authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let email = authDataResult.user.email else {
            return
        }
        db.collection(DatabaseService.usersCollection)
            .document(authDataResult.user.uid)
            .setData(["email" : email,
                      "createdDate": Timestamp(date: Date()),
                      "userId": authDataResult.user.uid,
                      "hasGuaridan":hasGuardian]) { (error) in
                        
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(true))
                        }
        }
    }
    
    func updateDatabaseUserConfirmationInfo(pin: String,
                                            username: String,
                                            completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.usersCollection).document(user.uid).updateData(["pin": pin, "username": username]) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(true))
                    }
        }
    }
    

    func updateDatabaseUser(displayName: String?,
                            photoURL: String?,
                            username: String,
                            address: String,
                            zipcode: String,
                            coordinates: String?,
                            guardianName: String?,
                            guardianPhone: String?,
                            completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.usersCollection)
            .document(user.uid).updateData([
                "userID": user.uid,
                "photoURL" : photoURL ?? "", "displayName" : displayName ?? "", "username": username, "userAddress":address,"userZipcode":zipcode, "guardianName":guardianName ?? "no guardian name", "guardianPhone":guardianPhone ?? "no guardian phone number"] ) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(true))
                    }
        }
    }
    
    func fetchUserInfo(completion: @escaping (Result<UserModel, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.usersCollection).document(user.uid).addSnapshotListener { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot?.data() {
                let userInfo = UserModel(snapshot)
                completion(.success(userInfo))
            }
        }
    }
    
}
