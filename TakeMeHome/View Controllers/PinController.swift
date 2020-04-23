//
//  PinController.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/22/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class PinController: UIViewController {
    
    @IBOutlet weak var pinLable: UILabel!
    
    private let db = DatabaseService.shared
    private var authSession = AuthenticationService()
    private var enteredNumber = ""
    private var hiddenPin = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinLable.text = ""
        // Do any additional setup after loading the view.
    }

    @IBAction func numberButtonPressed(_ sender: UIButton) {
        guard let number = sender.titleLabel?.text else { return }
        print(number)
        switch number {
        case "1":
            hiddenPin += "*"
            pinLable.text = hiddenPin
            enteredNumber += number
        case "2":
            hiddenPin += "*"
            pinLable.text = hiddenPin
            enteredNumber += number
        case "3":
            hiddenPin += "*"
            pinLable.text = hiddenPin
            enteredNumber += number
        case "4":
            hiddenPin += "*"
            pinLable.text = hiddenPin
            enteredNumber += number
        case "5":
            hiddenPin += "*"
            pinLable.text = hiddenPin
            enteredNumber += number
        case "6":
            hiddenPin += "*"
            pinLable.text = hiddenPin
            enteredNumber += number
        case "7":
            hiddenPin += "*"
            pinLable.text = hiddenPin
            enteredNumber += number
        case "8":
            hiddenPin += "*"
            pinLable.text = hiddenPin
            enteredNumber += number
        case "9":
            hiddenPin += "*"
            pinLable.text = hiddenPin
            enteredNumber += number
        case "0":
            hiddenPin += "*"
            pinLable.text = hiddenPin
            enteredNumber += number
        default:
            fatalError("could unwrap the numbers")
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        if db.pin == enteredNumber {
            print("it works")
        }
        UIViewController.showViewController(storyboardName: "SettingsView", viewControllerID: "SettingsViewController")
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        UIViewController.showViewController(storyboardName: "UserView", viewControllerID: "UserViewController")
    }
    
}
