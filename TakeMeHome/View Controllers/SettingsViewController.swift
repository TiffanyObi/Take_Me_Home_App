//
//  SettingsViewController.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import FirebaseAuth

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
    
    @IBOutlet weak var signOutButton: UIButton!
    
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
    private var db = DatabaseService.shared
    private var displayName = ""
    private var username = ""
    private var userAddress = ""
    private var userZipcode = ""
    private var userPhonenumber = ""
    private var guardianName = ""
    private var guardianAddress = ""
    private var guardianPhonenumber = ""
    private var guardianZipcode = ""
    
    private var userInfo: UserModel? {
        didSet {
            updateSettingsWithDatabaseUserInfo()
            displayName = userInfo?.displayName ?? ""
            username = userInfo?.username ?? ""
            userAddress = userInfo?.userAddress ?? ""
            userZipcode = userInfo?.userZipcode ?? ""
            userPhonenumber = userInfo?.userPhoneNumber ?? ""
            guardianName = userInfo?.guardianName ?? ""
            guardianAddress = userInfo?.guardianAddress ?? ""
            guardianPhonenumber = userInfo?.guardianPhone ?? ""
            guardianZipcode = userInfo?.guardianZipcode ?? ""
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserInfo()
        configureTextfields()
        configureGuardianUI()
        registerForKeyboardNotifications()
        view.addGestureRecognizer(tapGesture)
      updateSettingsWithDatabaseUserInfo()
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
        guardianZipcodeTextfield.delegate = self
    }
    
    func configureGuardianUI(){
        if db.hasGardian {
            activeGuardianSwitch.isOn = true
            guardianNameTexfield.isEnabled = true
            guardianAddressTextfield.isEnabled = true
            guardianZipcodeTextfield.isEnabled = true
            guardianPhoneNumberTextfield.isEnabled = true
        } else if !db.hasGardian {
            activeGuardianSwitch.isOn = false
            guardianNameTexfield.isEnabled = false
            guardianAddressTextfield.isEnabled = false
            guardianZipcodeTextfield.isEnabled = false
            guardianPhoneNumberTextfield.isEnabled = false
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
    
    func updateSettingsWithDatabaseUserInfo(){
        displayNameTextfield.text = userInfo?.displayName
        usernameTexfield.text = userInfo?.username
        userAddressTextfield.text = userInfo?.userAddress
        userZipcodeTextfield.text = userInfo?.userZipcode
        userPhoneNumberTextfield.text = userInfo?.userPhoneNumber
        guardianNameTexfield.text = userInfo?.guardianName ?? ""
        guardianAddressTextfield.text = userInfo?.guardianAddress
        guardianPhoneNumberTextfield.text = userInfo?.guardianPhone ?? ""
        guardianZipcodeTextfield.text = userInfo?.guardianZipcode
    }
    
    @IBAction func activeGuardianSwitchToggled(_ sender: UISwitch) {
        if db.hasGardian {
            sender.setOn(false, animated: true)
            db.hasGardian = false
            
            print("has guardian was true and is now \(db.hasGardian.description)")
        } else if !db.hasGardian {
            sender.setOn(true, animated: true)
            db.hasGardian = true
              print("has guardian was false and is now \(db.hasGardian.description)")
        }
       
    }
    
    
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
        AuthenticationService().signoutCurrentUser()
        
    }
    
   
    @IBAction func saveButtonPressed(_ sender: UIButton) {
  
        updateDatabaseWithUserContactInfo(with: displayName, photoURL: "", userPhoneNumber: userPhonenumber, name: username, address: userAddress, zipcode: userZipcode, guardianName: guardianName, guardianPhone: guardianPhonenumber, guardianAddress: guardianAddress, guardianZipcode: guardianZipcode)
        
        UIViewController.showViewController(storyboardName: "UserView", viewControllerID: "UserViewController")
    }
    
    
    
    private func updateDatabaseWithUserContactInfo(with displayName: String, photoURL:String,userPhoneNumber:String, name:String, address:String, zipcode:String,guardianName:String,guardianPhone:String, guardianAddress:String,guardianZipcode:String){
        database.updateDatabaseUser(displayName: displayName, guardianAddress: guardianAddress, photoURL: photoURL, username: name, address: address, zipcode: zipcode, userPhone: userPhonenumber, coordinates: nil, guardianName: guardianName, guardianPhone: guardianPhone, guardianZipcode: guardianZipcode) { [weak self] (result) in
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
        guardianZipcodeTextfield.resignFirstResponder()
        
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
            guardianName = guardianNameText ?? ""
                   print(guardianName)
        }
        if textField == guardianAddressTextfield {
         let guardianAddressText = guardianAddressTextfield.text
            guardianAddress = guardianAddressText ?? ""
                   print(guardianAddress)
        }
        if textField == guardianPhoneNumberTextfield {
        let guardianPhonenumberText = guardianPhoneNumberTextfield.text
            guardianPhonenumber = guardianPhonenumberText ?? ""
                   print(guardianPhonenumber)
        }
        if textField == guardianZipcodeTextfield {
            let guardianZipCodeText = guardianZipcodeTextfield.text
        guardianZipcode = guardianZipCodeText ?? ""
            print(guardianZipcode)
    
    }
    
}
}
