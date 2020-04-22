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
    
    private var enteredNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func numberButtonPressed(_ sender: UIButton) {
        guard let number = sender.titleLabel?.text else { return }
        
        switch number {
        case "1":
            pinLable.text = pinLable.text ?? "*" + "*"
            enteredNumber += number
        case "2":
            pinLable.text = pinLable.text ?? "*" + "*"
            enteredNumber += number
        case "3":
            pinLable.text = pinLable.text ?? "*" + "*"
            enteredNumber += number
        case "4":
            pinLable.text = pinLable.text ?? "*" + "*"
            enteredNumber += number
        case "5":
            pinLable.text = pinLable.text ?? "*" + "*"
            enteredNumber += number
        case "6":
            pinLable.text = pinLable.text ?? "*" + "*"
            enteredNumber += number
        case "7":
            pinLable.text = pinLable.text ?? "*" + "*"
            enteredNumber += number
        case "8":
            pinLable.text = pinLable.text ?? "*" + "*"
            enteredNumber += number
        case "9":
            pinLable.text = pinLable.text ?? "*" + "*"
            enteredNumber += number
        case "0":
            pinLable.text = pinLable.text ?? "*" + "*"
            enteredNumber += number
        default:
            fatalError("could unwrap the numbers")
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
    }
    
}
