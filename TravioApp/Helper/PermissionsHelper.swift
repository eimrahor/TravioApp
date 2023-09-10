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
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                // Kullanıcı izni verdi, kamera işlemlerinizi burada gerçekleştirin
            } else {
                // Kullanıcı izin vermedi, gerekli işlemleri yapabilirsiniz
            }
        }
    }
    
    func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized: break
                // Kullanıcı izni verdi, galeri işlemlerinizi burada gerçekleştirin
            case .denied, .restricted: break
                // Kullanıcı izni reddetti veya kısıtlı, kullanıcıyı izinleri ayarlamak için yönlendirin
            case .notDetermined:
                // Kullanıcı daha önce izin vermemiş, izin isteği gösterebilirsiniz
                break
            default:
                break
            }
        }
    }
    
    let locationManager = CLLocationManager()

    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization() // Kullanıldığında konum izni için
        // veya
        // locationManager.requestAlwaysAuthorization() // Her zaman konum izni için
    }
}
