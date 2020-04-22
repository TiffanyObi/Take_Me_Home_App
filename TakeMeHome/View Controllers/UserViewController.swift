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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserInfo()
    }
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        authSession.signoutCurrentUser()
    }
    
    private func fetchUserInfo() {
        db.fetchUserInfo { (result) in
            switch result {
            case .failure(let error):
                fatalError("\(error.localizedDescription)")
            case .success(let userData):
                DispatchQueue.main.async {
                    self.userInfo = userData
                }
            }
        }
    }
    
}
