//
//  SettingsViewController.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var displayNameTextfield: UITextField!
    
    @IBOutlet weak var usernameTexfield: UITextField!
    
    @IBOutlet weak var userAddressTextfield: UITextField!
    
    @IBOutlet weak var userZipcodeTextfield: UITextField!
    
    @IBOutlet weak var userPhoneNumberTextfield: UITextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var guardianNameTexfield: UITextField!
    
    @IBOutlet weak var guardianAddressTextfield: UITextField!
    
    @IBOutlet weak var guardianPhoneNumberTextfield: UITextField!
    
    @IBOutlet weak var guardiamImageView: UIImageView!
    
    @IBOutlet weak var activeGuardianSwitch: UISwitch!
    
    
    private var database = DatabaseService()
    private var displayName = ""
    private var username = ""
    private var userAddress = ""
    private var userZipcode = ""
    private var userPhonenumber = ""
    private var guardianName = ""
    private var guardianAddress = ""
    private var guardianPhonenumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func configureTextfields(){
        displayNameTextfield.delegate = self
        usernameTexfield.delegate = self
        userAddressTextfield.delegate = self
        userZipcodeTextfield.delegate = self
        userPhoneNumberTextfield.delegate = self
        guardianNameTexfield.delegate = self
        guardianAddressTextfield.delegate = self
        guardianPhoneNumberTextfield.delegate = self
        guardianPhoneNumberTextfield.delegate = self
    }
    

    @IBAction func activeGuardianSwitchToggled(_ sender: UISwitch) {
    }
    
    private func updateDatabaseWithUserContactInfo(with displayName: String, photoURL:String, name:String, address:String, zipcode:String,guardianName:String,guardianPhone:String){
        database.updateDatabaseUser(displayName: displayName, photoURL: photoURL, name: name, address: address, zipcode: zipcode, coordinates: nil, guardianName: guardianName, guardianPhone: guardianPhone) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error Saving Contact Info: Error - \(error)", message: "Please try again later")
                
            case .success(true):
                self?.showAlert(title: "Successfully Updated", message: nil)
            case .success(false):
                self?.showAlert(title: "Were Having Technical Difficulties", message: "Try again late")
            
            }
        }
        
    }

    
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let displaynameText = displayNameTextfield.text,
            !displaynameText.isEmpty,
            let usernameText = usernameTexfield.text,
            !usernameText.isEmpty,
            let userAddressText = userAddressTextfield.text,
            !userAddressText.isEmpty,
            let userZipcodeText = userZipcodeTextfield.text,
            !userZipcodeText.isEmpty,
            let userPhonenumberText = userPhoneNumberTextfield.text,
            !userPhonenumberText.isEmpty,
            let guardianNameText = guardianNameTexfield.text,
            let guardianAddressText = guardianAddressTextfield.text,
            let guardianPhonenumberText = guardianPhoneNumberTextfield.text else { return false }
        
        
        
        
        
        
        
        
        return true
    }
    
}
