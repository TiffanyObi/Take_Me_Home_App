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
    
//    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var guardianNameTexfield: UITextField!
    
    @IBOutlet weak var guardianAddressTextfield: UITextField!
    
    @IBOutlet weak var guardianPhoneNumberTextfield: UITextField!
    
    @IBOutlet weak var guardianZipcodeTextfield: UITextField!
    
    //    @IBOutlet weak var guardiamImageView: UIImageView!
    
    @IBOutlet weak var activeGuardianSwitch: UISwitch!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    
    var constraint: CGFloat = 0
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(keyboardWillHide(_:)))
        return gesture
    }()
    
     var keyboardIsVisible = false
//     var constraint: NSLayoutConstraint!
    
    private var database = DatabaseService()
    private var displayName = ""
    private var username = ""
    private var userAddress = ""
    private var userZipcode = ""
    private var userPhonenumber = ""
    private var guardianName = ""
    private var guardianAddress = ""
    private var guardianPhonenumber = ""
    private var guardianZipcode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureTextfields()
        registerForKeyboardNotifications()
        view.addGestureRecognizer(tapGesture)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterForKeyboardNotifications()
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
    
   
    @IBAction func saveButtonPressed(_ sender: UIButton) {
           updateDatabaseWithUserContactInfo(with: displayName, photoURL: "", name: username, address: userAddress, zipcode: userZipcode, guardianName: guardianName, guardianPhone: guardianAddress)
            UIViewController.showViewController(storyboardName: "UserView", viewControllerID: "UserViewController")
    }
    
    
    
    private func updateDatabaseWithUserContactInfo(with displayName: String, photoURL:String, name:String, address:String, zipcode:String,guardianName:String,guardianPhone:String){
        database.updateDatabaseUser(displayName: displayName, photoURL: photoURL, username: name, address: address, zipcode: zipcode, coordinates: nil, guardianName: guardianName, guardianPhone: guardianPhone) { [weak self] (result) in
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

    private func registerForKeyboardNotifications() {
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
       
       private func unregisterForKeyboardNotifications() {
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
       }
       
       @objc private func keyboardWillShow(_ notification: NSNotification) {
           print("keyboardWillShow")

           guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
               return
           }

           moveKeyboardUp(keyboardFrame.size.height)
       }
       
       @objc private func keyboardWillHide(_ notification: NSNotification) {
        displayNameTextfield.resignFirstResponder()
        usernameTexfield.resignFirstResponder()
        userAddressTextfield.resignFirstResponder()
        userZipcodeTextfield.resignFirstResponder()
        userPhoneNumberTextfield.resignFirstResponder()
    guardianNameTexfield.resignFirstResponder()
    guardianAddressTextfield.resignFirstResponder()
    guardianPhoneNumberTextfield.resignFirstResponder()
        
        
       }
       
       func moveKeyboardUp(_ height: CGFloat) {
           if keyboardIsVisible {return}
        constraint = bottomContraint.constant
           bottomContraint.constant -= (height + 100)

        print(bottomContraint.constant)
           UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseIn, animations: {
               self.view.layoutIfNeeded()
           }, completion: nil)
           keyboardIsVisible = true
       }


       func resetUI() {


           bottomContraint.constant -= (constraint + 100)

           keyboardIsVisible = false
       }

}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == displayNameTextfield {
        guard let displaynameText = displayNameTextfield.text,
            !displaynameText.isEmpty else { return }
            displayName = displaynameText
            print(displayName)
        }
        if textField == usernameTexfield {
           guard let usernameText = usernameTexfield.text,
            !usernameText.isEmpty else { return }
            username = usernameText
            print(username)
        }
        if textField == userAddressTextfield {
        guard let userAddressText = userAddressTextfield.text,
            !userAddressText.isEmpty else { return }
            userAddress = userAddressText
                    print(userAddress)
        }
        if textField == userZipcodeTextfield {
        
            guard let userZipcodeText = userZipcodeTextfield.text,
                !userZipcodeText.isEmpty else { return }
            userZipcode = userZipcodeText
            print(userZipcode)
        }
        if textField == userPhoneNumberTextfield {
           guard let userPhonenumberText = userPhoneNumberTextfield.text,
            !userPhonenumberText.isEmpty else { return }
            userPhonenumber = userPhonenumberText
                  print(userPhonenumber)
        }
        if textField == guardianNameTexfield {
            let guardianNameText = guardianNameTexfield.text
            guardianName = guardianNameText ?? "no guardian name"
                   print(guardianName)
        }
        if textField == guardianAddressTextfield {
         let guardianAddressText = guardianAddressTextfield.text
            guardianAddress = guardianAddressText ?? "no guardian address"
                   print(guardianAddress)
        }
        if textField == guardianPhoneNumberTextfield {
        let guardianPhonenumberText = guardianPhoneNumberTextfield.text
            guardianPhonenumber = guardianPhonenumberText ?? "no guardian phone number"
                   print(guardianPhonenumber)
        }
        
    
    }
    
}
