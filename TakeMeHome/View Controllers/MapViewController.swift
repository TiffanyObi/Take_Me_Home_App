//
//  MapViewController.swift
//  TakeMeHome
//
//  Created by Tanya Burke on 4/22/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationSession = CoreLocationSession()
    var annotation = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadMapView()
//
//        convertPlacemarkToCooderinate()
        mapView.showsUserLocation = false
      centerViewOnUserLocation()
     
        mapView.showsUserLocation = true
        mapView.delegate = self
        
       
    }
    
    

    
    private func convertPlacemarkToCooderinate(){
        locationSession.convertPlacemarkToCooderinate(addressString: "503 E 43rd Street, Brooklyn N.Y., 11203")
    }
    

    
    func centerViewOnUserLocation() {
             let regionInMeters: Double = 250
             
           if let location = locationSession.locationManager.location?.coordinate {
                 let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
           
    
            mapView.setRegion(region, animated: false)
            mapView.userLocation.title = "User Location"
                        }
     
    }
    
}
    

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect")
        
     
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        let identifier = "locationAnnotation"
        var annotationView: MKPinAnnotationView

        // try to dequeue and reuse annotation view
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            annotationView = dequeueView
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("calloutAccessoryControlTapped")
    }
    
    
}
