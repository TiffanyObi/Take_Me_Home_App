//
//  LoginViewController.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTypeDescriptionLabel: UILabel!
    
    private var db = DatabaseService.shared
    private var authSession = AuthenticationService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addTarget(self, action: #selector(enterPressed), for: .editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(enterPressed), for: .editingDidEndOnExit)
    }
    
    @objc func enterPressed() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        db.email = email
        db.password = password
        
        if loginButton.titleLabel?.text == "Log in" {
            authSession.signExistingUser(email: email, password: password) { [weak self] (result) in
              switch result {
              case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Please enter valid email/password", message: error.localizedDescription)
                }
              case .success:
                DispatchQueue.main.async {
                    UIViewController.showViewController(storyboardName: "UserView", viewControllerID: "UserViewController")
                }
              }
            }
            
        } else {
            UIViewController.showViewController(storyboardName: "Login_Selection_AppState", viewControllerID: "SelectionViewController")
        }
        
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "create" {
            loginButton.setTitle("Sign up", for: .normal)
            sender.setTitle("log in", for: .normal)
            loginTypeDescriptionLabel.text = "If you already have an account press"
        } else {
            loginButton.setTitle("Log in", for: .normal)
            sender.setTitle("create", for: .normal)
            loginTypeDescriptionLabel.text = "If you don't have a account press"
        }
    }
}

