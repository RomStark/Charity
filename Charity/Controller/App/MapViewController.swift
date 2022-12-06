//
//  MapViewController.swift
//  Charity
//
//  Created by Al Stark on 30.11.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    private let map = MKMapView()
    private var locationManager = CLLocationManager()

    private var selfCoordinate = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupLocationManager()
    }
    
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        

        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            map.setRegion(viewRegion, animated: false)
        }
        
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    
    private func setupMap() {
        view.addSubview(map)
        
        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        map.showsUserLocation = true
        
        let noLocation = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegion(center: noLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        map.setRegion(viewRegion, animated: false)
        for charity in MainTableViewController.charities {
            guard let logitude = charity.logitude,
                  let latitude = charity.latitude else {
                continue
            }
            let charityAnnotation = MKPointAnnotation()
            charityAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude),
                                                           longitude: CLLocationDegrees(logitude))
            charityAnnotation.title = charity.name
            map.addAnnotation(charityAnnotation)
        }
    }
}

//extension MapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else {
//            return
//        }
////        selfCoordinate.latitude = coordinate.latitude
////        selfCoordinate.longitude = coordinate.longitude
//    }
//}
