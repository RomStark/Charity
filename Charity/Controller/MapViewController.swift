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
    private let locationManager = CLLocationManager()

    private var selfCoordinate = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        setupMap()
        
    }
    
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        map.setRegion(
            MKCoordinateRegion(
                center: selfCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1,
                                       longitudeDelta: 0.1)
            ),
            animated: true
        )
        let annotation = MKPointAnnotation()
        annotation.coordinate = selfCoordinate
        annotation.title = "Вы тут"
        map.addAnnotation(annotation)
    }
    
    private func setupMap() {
        view.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        if CLLocationManager.locationServicesEnabled() {
            if selfCoordinate.longitude != 0 {
                setupLocationManager()
            }
        }
        
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

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else {
            print(12)
            return
        }
        print(33)
        selfCoordinate.latitude = coordinate.latitude
        selfCoordinate.longitude = coordinate.longitude
    }
}
