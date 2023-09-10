//
//  SecuritySettingsVM.swift
//  TravioApp
//
//  Created by Kurumsal on 1.09.2023.
//

import Foundation
import AVFoundation
import UIKit
import Photos

class SecuritySettingsVM{
    
    var passwordSettingsDatas:[PasswordSettingsData] = [PasswordSettingsData(titleText: "New Password", placeHolderText: "********"),PasswordSettingsData(titleText: "New Password Confirm", placeHolderText: "********")]
    
    var privacySettingsDatas:[PrivacySettingsData] = [PrivacySettingsData(titleText: "Camera", switchState: true,perrmissionType: .CameraPermission),PrivacySettingsData(titleText: "Photo Library", switchState: false,perrmissionType: .PhotoLibraryPermission),PrivacySettingsData(titleText: "Location", switchState: true,perrmissionType: .LocationPermission)]
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(cameraPermissionChanged), name: .AVCaptureDeviceWasConnected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cameraPermissionChanged), name: .AVCaptureDeviceWasDisconnected, object: nil)
        addPhotoLibraryPermissionObserver()
    }
    
    @objc func cameraPermissionChanged(){
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized,.notDetermined:
            print("switch i aktif")
        case .denied,.restricted:
            print("switch i pasif")
        default:
            print("switch i pasif")
        }
    }
    
    func addPhotoLibraryPermissionObserver() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                print("Fotoğraf kütüphanesi izni verildi.")
            case .denied, .restricted:
                print("Fotoğraf kütüphanesi izni reddedildi veya kısıtlandı.")
            case .notDetermined:
                print("Fotoğraf kütüphanesi izni daha önce verilmemiş.")
            default:
                break
            }
        }
    }
    
    func removeCameraPermissionObserver() {
        NotificationCenter.default.removeObserver(self, name: .AVCaptureDeviceWasConnected, object: nil)
        NotificationCenter.default.removeObserver(self, name: .AVCaptureDeviceWasDisconnected, object: nil)
    }
    
    deinit {
        removeCameraPermissionObserver()
    }

}
