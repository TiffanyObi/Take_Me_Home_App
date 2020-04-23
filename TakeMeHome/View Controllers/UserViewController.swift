//
//  UserViewController.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    private var db = DatabaseService.shared
    private var authSession = AuthenticationService()
    
    private var userInfo: UserModel! {
        didSet {
            print(userInfo.username)
            print(userInfo.email)
            db.pin = userInfo.pin
            
            if userInfo.hasGuaridan == "True" {
                db.hasGardian = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserInfo()
    }
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        if db.hasGardian {
            UIViewController.showViewController(storyboardName: "Pin", viewControllerID: "PinController")
        } else {
            authSession.signoutCurrentUser()
            UIViewController.showViewController(storyboardName: "SettingsView", viewControllerID: "SettingsViewController")
        }
        
    }
    
    private func fetchUserInfo() {
        db.fetchUserInfo { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let userData):
                DispatchQueue.main.async {
                    self.userInfo = userData
                }
            }
        }
    }
    
    
}
