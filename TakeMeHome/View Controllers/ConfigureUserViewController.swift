//
//  AppStateViewController.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class ConfigureUserViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    private let db = DatabaseService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        guard let name = nameTextField.text, name.count > 1 else { return }
        db.updateDatabaseUser(name: name, address: "", zipcode: "", coordinates: "", guardianName: "", guardianPhone: "") { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Please enter a valid user name", message: error.localizedDescription)
                }
            case .success:
                UIViewController.showViewController(storyboardName: "Login_Selection_AppState", viewControllerID: "UserViewController")
            }
        }
    }
}
