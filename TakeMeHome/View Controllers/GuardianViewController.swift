//
//  GuardianViewController.swift
//  TakeMeHome
//
//  Created by Tiffany Obi on 4/20/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import MapKit

class GuardianViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var statusAlertLabel: UILabel!
    
    //can possibly add the username/ personname to button text with this
    @IBOutlet weak var userCurreLocationUpdateText: UIButton!
    
//    var user: UserModel! {
//        didSet{
//            print(user.username)
//
//            homeAddress = "\(user.userAddress), \(user.userZipcode)"
//
////           homeCoordinates = convertPlaceNameToCoordinate(addressString: ("\(user.userAddress), \(user.userZipcode)"))®
//
//        }
//    }
//
//    var homeAddress = "104-15 125th street, 11419"
//    //var homeCoordinates =
//
//     private let locationSession = CoreLocationSession()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        testing converting coordinate to placemark
//        convertCoordinateToPlacemark()
//
////         testing converting place name to coordinate
//        convertPlaceNameToCoordinate()
//
//        // configure map view
//        // attempt to show the user's current location
//        mapView.showsUserLocation = true
//        mapView.delegate = self
//
//        loadMapView()
//    }
//
//    private func makeAnnotations() -> [MKPointAnnotation]{
//        var annotations = [MKPointAnnotation]()
//            let annotation = MKPointAnnotation()
//
//        //annotation.title = "\()"
//            annotation.coordinate = CLLocationCoordinate2D(latitude: 40.6430471, longitude: -73.9359625)
//            annotations.append(annotation)
//        return annotations
//    }
//
//
//    private func loadMapView() {
//     let annotations = makeAnnotations()
//     mapView.showAnnotations(annotations, animated: true)
//   }
//
//
//    private func convertCoordinateToPlacemark() {
//
//
//      //locationSession.convertCoordinateToPlacemark(coordinate: homeCoordinates)
//    }
//
//    private func startMonitoringRegion() {
////      var homeCoordinates = convertPlaceNameToCoordinate(addressString: ("\(user.userAddress), \(user.userZipcode)"))
//
//      // let location = locationManager.location //users location, need to be home address
//       let identifier = "monitoring region"
//
//      // let region = CLCircularRegion(center: location?.coordinate ?? (CLLocationCoordinate2D(latitude: 40.7027, longitude: 73.7890)) , radius: 30, identifier: identifier)
//       //this is what we would change to adjust when monitoring atrts automatically
//       //region.notifyOnEntry = true
//       //this as well
//       //region.notifyOnExit = false
//
//       //locationManager.startMonitoring(for: region)
//
//     }
//
//    public func getDirections() {
//       //user current position
//      //  let coordinate = locationSession.location.coordinate
//
//            let request = MKDirections.Request()
//
//            request.source = MKMapItem.forCurrentLocation()
//        //would be user home
//          // request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate ?? (CLLocationCoordinate2D(latitude: 40.7027, longitude: 73.7890)))
//            request.transportType = .any
//            let directions = MKDirections(request: request)
//            directions.calculate { //[unowned self]
//                (response, error) in
//                guard let unwrappedResponse = response else { return }
//                for route in unwrappedResponse.routes {
//                //    self.faveDatailViews.venueMap.addOverlay(route.polyline)
//                //    self.faveDatailViews.venueMap.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//                }
//        }
//    }
//
//
//    @IBAction func currentUserLocationPressed(_ sender: UIButton) {
//    }
//
//
//
//private func convertPlaceNameToCoordinate() {
//    locationSession.convertPlaceNameToCoordinate(addressString: "pursuit, queens")
//  }
//
//}
//
//extension GuardianViewController: MKMapViewDelegate {
//
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//    print("didSelect")
//  }
//
//  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//    guard annotation is MKPointAnnotation else {
//      return nil
//    }
//    let identifier = "locationAnnotation"
//    var annotationView: MKPinAnnotationView
//
//    // try to dequeue and reuse annotation view
//    if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
//      annotationView = dequeueView
//    } else {
//      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//      annotationView.canShowCallout = true
//    }
//    return annotationView
//  }
//
//  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//    print("calloutAccessoryControlTapped")
//  }
}
