//
//  UserViewController.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var db = DatabaseService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        db.signoutButtonPressed()
    }
    
}
