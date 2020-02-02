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
    @IBOutlet weak var dropItemButton: UIButton!
    
    let itemPin = MKPointAnnotation()

   
    
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
    
    func currentLocation() -> CLLocationCoordinate2D{
       locationManager.delegate = self
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
       if #available(iOS 11.0, *) {
          locationManager.showsBackgroundLocationIndicator = true
       } else {
          // Fallback on earlier versions
       }
       locationManager.startUpdatingLocation()
        do{
            return try locationManager.location!.coordinate
        } catch {
            return CLLocationCoordinate2D()
        }
        
    }
    
    
    @IBAction func buttonWasPressed(_ sender: Any) {
        // Create the alert controller
        let alertController = UIAlertController(title: "What are you leaving here?", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            let answer = alertController.textFields![0]
            NSLog(answer.text!)
            self.itemPin.coordinate = self.currentLocation()
            //self.itemPin.coordinate = self.stages
            self.itemPin.title = answer.text!
            self.mapView.addAnnotation(self.itemPin)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true) //this fixed it
    }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
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
