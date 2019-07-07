//
//  LocationHandler.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 17/06/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate : class {
    func locationFetched()
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var manager : CLLocationManager!
    var currentLocation : CLLocation?
    weak var delegate : LocationManagerDelegate?
    
    // MARK: - Properties
    private static var sharedLocationManager: LocationManager = {
        let locationManager = LocationManager()
        return locationManager
    }()
    
    // MARK: - Accessors
    class func shared() -> LocationManager {
        return sharedLocationManager
    }
    
    func launch() {
        if manager == nil {
            manager = CLLocationManager()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
        }
        if CLLocationManager.locationServicesEnabled() {
            currentLocation = nil
            manager.startUpdatingLocation()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if (currentLocation == nil) {
            currentLocation = locations[0] as CLLocation
            self.delegate?.locationFetched()
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        print("Error \(error)")
    }

}
