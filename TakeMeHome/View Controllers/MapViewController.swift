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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMapView()
        
        convertPlacemarkToCooderinate()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
    }
    
  
    
    
    private func loadMapView() {
        let annotations = makeAnnotations()
        mapView.showAnnotations(annotations, animated: true)
    }
    
  
    
    
    private func convertPlacemarkToCooderinate(){
        locationSession.convertPlacemarkToCooderinate(addressString: "503 E 43rd Street, Brooklyn N.Y., 11203")
    }
    
    private func makeAnnotations() -> [MKPointAnnotation]{
        var annotations = [MKPointAnnotation]()
        
        let annotation = MKPointAnnotation()
        
        annotation.title = "Tiffs house"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.6430471, longitude: -73.9359625)
        annotations.append(annotation)
        
        return annotations
    }
    
    private func getDirections() {
        let coordinate = CLLocationCoordinate2D(latitude: 40.7057, longitude: -73.8272)
        
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        request.transportType = .any
        let directions = MKDirections(request: request)
        directions.calculate { //[unowned self]
            (response, error) in
            guard let unwrappedResponse = response else { return }
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect")
        
        getDirections()
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