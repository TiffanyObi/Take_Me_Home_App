//
//  SelectionViewController.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SelectionViewController: UIViewController {
    
    private var db = DatabaseService.shared
    private var authSession = AuthenticationService()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func yesButtonPressed(_ sender: UIButton) {
        let email = db.email
        let password = db.password
        print(email)
        print(password)
        authSession.createNewUser(email: email, password: password) { [weak self] (result) in
          switch result {
          case .failure(let error):
            DispatchQueue.main.async {
                self?.faildCreatingAccount(error: error)
            }
          case .success(let authDataResult):
            DispatchQueue.main.async {
                self?.db.hasGardian = true
                self?.createDatabaseUser(authDataResult: authDataResult, hasGardian: "True")
            }
          }
        }
        
    }
    
    @IBAction func noButtonPressed(_ sender: UIButton) {
        let email = db.email
        let password = db.password
        print(email)
        print(password)
        authSession.createNewUser(email: email, password: password) { [weak self] (result) in
          switch result {
          case .failure(let error):
            DispatchQueue.main.async {
                self?.faildCreatingAccount(error: error)
            }
          case .success(let authDataResult):
            DispatchQueue.main.async {
                self?.db.hasGardian = false
                self?.createDatabaseUser(authDataResult: authDataResult, hasGardian: "False")
            }
          }
        }
    }

    private func createDatabaseUser(authDataResult: AuthDataResult, hasGardian: String) {
        db.createDatabaseUser(hasGuardian: hasGardian, authDataResult: authDataResult) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Account error", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    UIViewController.showViewController(storyboardName: "Login_Selection_AppState", viewControllerID: "ConfigureUserViewController")
                }
            }
        }
    }
    
    private func faildCreatingAccount(error: Error) {
        let title = "Please enter valid email/password"
        let message = error.localizedDescription
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let backAction = UIAlertAction(title: "Back", style: .default) { (alertAction) in
            UIViewController.showViewController(storyboardName: "Login_Selection_AppState", viewControllerID: "LoginViewController")
        }
        alertController.addAction(backAction)
        present(alertController, animated: true)
    }
}
