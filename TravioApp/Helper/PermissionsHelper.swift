//
//  PermissionsHelper.swift
//  TravioApp
//
//  Created by Elif Poyraz on 10.09.2023.
//

import Foundation
import AVFoundation
import UIKit
import Photos

class PermissionsHelper{
    static let shared = PermissionsHelper()
    
    func requestCameraPermission( complete: @escaping (Bool)->(Void)) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
               complete(true)
            } else {
               complete(false)
            }
        }
    }
    
    func requestPhotoLibraryPermission(complete: @escaping (Bool)->(Void)) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                complete(true)
                break
            case .denied, .restricted:
                complete(false)
                break
            case .notDetermined:
                complete(false)
                break
            default:
                break
            }
        }
    }
    
    let locationManager = CLLocationManager()

    func requestLocationPermission() {
        
        PermissionsHelper.shared.locationManager.requestWhenInUseAuthorization() // Kullanıldığında konum izni için
        // veya
        // locationManager.requestAlwaysAuthorization() // Her zaman konum izni için
    }
}
