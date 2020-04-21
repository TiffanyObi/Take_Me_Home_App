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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if loginButton.titleLabel?.text == "Log in" {
            UIViewController .showViewController(storyboardName: "Login_Selection_AppState", viewControllerID: "AppStateViewController")
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

