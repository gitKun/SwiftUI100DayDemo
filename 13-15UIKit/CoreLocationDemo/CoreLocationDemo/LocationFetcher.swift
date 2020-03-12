//
//  LocationFetcher.swift
//  CoreLocationDemo
//
//  Created by DR_Kun on 2020/3/12.
//  Copyright © 2020 kun. All rights reserved.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
   
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
    
}
