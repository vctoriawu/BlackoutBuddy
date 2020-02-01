//
//  ThirdViewController.swift
//  Blackout Buddy
//
//  Created by Victoria Armstrong on 2020-02-01.
//  Copyright © 2020 Victoria Armstrong. All rights reserved.
//

import UIKit
import MapKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    //fileprivate let locationManager:CLLocationManager = CLLocationManager()
    fileprivate let locationManager: CLLocationManager = {
       let manager = CLLocationManager()
       manager.requestWhenInUseAuthorization()
       return manager
    }()
    
    var stages = CLLocationCoordinate2DMake(44.2329299, -76.4942019)
    var home = CLLocationCoordinate2DMake(44.2363074, -76.4999346)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateMapRegion(place: home, rangeSpan: 500)
        
        setUpMapView()
        
    }
    
    
    func setUpMapView() {
       mapView.showsUserLocation = true
       mapView.showsCompass = true
       mapView.showsScale = true
       currentLocation()
    }
    
    func updateMapRegion(place:CLLocationCoordinate2D , rangeSpan:CLLocationDistance) {
        let region = MKCoordinateRegion.init(center: place, latitudinalMeters: rangeSpan, longitudinalMeters: rangeSpan)
        mapView.region = region
    }
    
    func currentLocation() {
       locationManager.delegate = self
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
       if #available(iOS 11.0, *) {
          locationManager.showsBackgroundLocationIndicator = true
       } else {
          // Fallback on earlier versions
       }
       locationManager.startUpdatingLocation()
    }
    
    
}

extension ThirdViewController: CLLocationManagerDelegate {
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let currentLocation = location.coordinate
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        locationManager.stopUpdatingLocation()
     }
     
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
     }
    
    
}
