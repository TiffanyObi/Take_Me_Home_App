//
//  UserViewController.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class UserViewController: UIViewController {
    
    private var db = DatabaseService.shared
    private var authSession = AuthenticationService()
    private var coreLocation = CoreLocationSession()
     private let center = UNUserNotificationCenter.current()
        private var notification = NotificationViewController()
    private var userInfo: UserModel! {
        didSet {
            print(userInfo.username)
            print(userInfo.email)
            db.pin = userInfo.pin
            userInfo.userAddress
            if userInfo.hasGuaridan == "True" {
                db.hasGardian = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         notification.checkNotificationAuthorization()
        center.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserInfo()
       
        notification.createLocalNotifications(with: "User has left the building")
    }
    
    
    
    
    @IBAction func takeMeHomePressed(_ sender: UIButton) {
        turnByturn()
    }
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        if db.hasGardian {
            UIViewController.showViewController(storyboardName: "Pin", viewControllerID: "PinController")
        } else {
            UIViewController.showViewController(storyboardName: "SettingsView", viewControllerID: "SettingsViewController")
        }
        
    }
    
    
       func turnByturn(){
//       coreLocation.convertPlacemarkToCooderinate(addressString: userInfo.userAddress)
        let placeMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.6430471, longitude: -73.9359625), addressDictionary: nil) //(Tiffs house coorinates)
            let mapItem = MKMapItem(placemark: placeMark)//placemark
        mapItem.name = "Home"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
        
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

extension UserViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}
