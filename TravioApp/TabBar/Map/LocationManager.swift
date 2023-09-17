//
//  LocationManager.swift
//  TravioApp
//
//  Created by imrahor on 17.09.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()

    var cPermission: Bool? {
        didSet {
            guard let cPermission = cPermission else { return }
            closure?(cPermission)
        }
    }
    
    let coordinate: CLLocationCoordinate2D?
    var closure: ((Bool)->())?
    
    init(coordinate: CLLocation) {
        let cLocation = CLLocationCoordinate2D(latitude: coordinate.coordinate.latitude, longitude: coordinate.coordinate.longitude)
        self.coordinate = cLocation
        super.init()
        
        // CLLocationManager'ı yapılandırma
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization() // Kullanıcıdan izin isteme
        locationManager.startUpdatingLocation() // Konum güncellemelerini başlatma
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last {
            let region = CLCircularRegion(center: userLocation.coordinate, radius: 100000.0, identifier: "UserLocation")
            
            guard let coordinate = coordinate else { return }
            if region.contains(coordinate) {
                cPermission = true
            } else {
                cPermission = false
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Konum alınamadı. Hata: \(error.localizedDescription)")
    }
}
