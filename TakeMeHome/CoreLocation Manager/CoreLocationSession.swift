//
//  CoreLocationManager.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//


import Foundation
import CoreLocation



class CoreLocationSession: NSObject {
  
  public var locationManager: CLLocationManager
//    var user: UserModel!
//    var user = UserModel(userID: user.userID, email: user.email, username: user.username, userAddress: user.userAddress, userZipcode: user.userZipcode, userPhotoURL: user.userPhotoURL, displayName: user.displayName, guardianName: user.guardianName, guardianPhone: user.guardianPhone, guardianPhotoURL: user.guardianPhotoURL)
    
  override init() {
    locationManager = CLLocationManager()
//    user = UserModel(userID: user.userID, email: user.email, username: user.username, userAddress: user.userAddress, userZipcode: user.userZipcode, userPhotoURL: user.userPhotoURL, displayName: user.displayName, guardianName: user.guardianName, guardianPhone: user.guardianPhone, guardianPhotoURL: user.guardianPhotoURL)
    super.init()
    locationManager.delegate = self
    
    // request the user's location
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    
    // the following keys needs to be added to the info.plist file
    /*
     NSLocationAlwaysAndWhenInUseUsageDescription
     NSLocationWhenInUseUsageDescription
    */
    
    
    // get updates for user location
    // more aggressive solution of GPS data collection
    //locationManager.startUpdatingLocation()
    
   
    startSignificantLocationChanges()
//    startMonitoringRegion()
  }
   
  
  private func startSignificantLocationChanges() {
    if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
     
      return
    }
    
    locationManager.startMonitoringSignificantLocationChanges()
  }
  
    
    
  public func convertCoordinateToPlacemark(coordinate: CLLocationCoordinate2D) {
    
    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    
    CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
      if let error = error {
        print("reverseGeocodeLocation: \(error)")
      }
      if let firstPlacemark = placemarks?.first {
        print("placemark info: \(firstPlacemark)")
      }
    }
  }
  
    
    
    
  public func convertPlaceNameToCoordinate(addressString: String) {
    // coverting an address to a coordinate
    CLGeocoder().geocodeAddressString(addressString) { (placemarks, error) in
      if let error = error {
        print("geocodeAddressString: \(error)")
      }
      if let firstPlacemark = placemarks?.first,
        let location = firstPlacemark.location {
        print("place name coordinate is \(location.coordinate)")
      }
    }
  }
  
  
 
    
       
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        if let region = region as? CLCircularRegion {
//            let identifier = region.identifier
//            triggerTaskAssociatedWithRegionIdentifier(regionID: identifier)
//        }
//    }
    
   
//}
    
//   public func getCoordinate( addressString : String,
//            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
//            if error == nil {
//                if let placemark = placemarks?[0] {
//                    let location = placemark.location!
//
//                    completionHandler(location.coordinate, nil)
//                    return
//                }
//            }
//
//            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
//        }
//    }
}

extension CoreLocationSession: CLLocationManagerDelegate {
    
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("didUpdateLocations: \(locations)")
    
    //use to update location on map?

  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("didFailWithError: \(error)")
    //if there's an error loading location
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
        //checks to see if app is authorized
    case .authorizedAlways:
      print("authorizedAlways")
    case .authorizedWhenInUse:
      print("authorizedWhenInUse")
    case .denied:
      print("denied")
    case .notDetermined:
      print("notDetermined")
    case .restricted:
      print("restricted")
    default:
      break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    print("didEnterRegion: \(region)")
    //did enter a area - can set a home location
  }
  
  func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    print("didExitRegion: \(region)")
    //did exit an area/ home/ l00 ft from guardian etc
  }
}
