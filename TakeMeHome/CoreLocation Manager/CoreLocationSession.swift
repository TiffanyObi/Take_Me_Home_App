//
//  CoreLocationManager.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//


import Foundation
import CoreLocation

//struct Location {
//let title: String
//let body: String
//let coordinate: CLLocationCoordinate2D
//let imageName: String
//    
//    public func getLocations() -> [Location] {
//    
//    return []
//    }
//}

class CoreLocationSession: NSObject {
  
  public var locationManager: CLLocationManager
  
    
  override init() {
    locationManager = CLLocationManager()
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
    
    // less aggressive on battery consumption and GPS data collection
    startSignificantLocationChanges()
    
    startMonitoringRegion()
  }
   
  
  private func startSignificantLocationChanges() {
    if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
      // not available on the device
      return
    }
    // less aggresive that the startUpdatingLocation() in GPS monitor chanages
    locationManager.startMonitoringSignificantLocationChanges()
  }
  
  public func convertCoordinateToPlacemark(coordinate: CLLocationCoordinate2D) {
    // we will use the CLGeocoder() class for converting coordinate (CLLocationCoordinate2D) to placemark (CLPlacemark)
    
    // we need to create CLLocation
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
  
  // monitor a CLRegion
  // a CLRegion is made up of a center coordinate and a radius in meters
  private func startMonitoringRegion() {
    let location = locationManager.location
    let identifier = "monitoring region"

    let region = CLCircularRegion(center: location?.coordinate ?? (CLLocationCoordinate2D(latitude: 40.7027, longitude: 73.7890)) , radius: 100, identifier: identifier)
    //this is what we would change to adjust when monitoring atrts automatically
    region.notifyOnEntry = true
    //this as well
    region.notifyOnExit = false
    
    locationManager.startMonitoring(for: region)
    
  }
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
