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
    
    var privacySettingsDatas:[PrivacySettingsData] = [PrivacySettingsData(titleText: "Camera",perrmissionType: .CameraPermission),PrivacySettingsData(titleText: "Photo Library",perrmissionType: .PhotoLibraryPermission),PrivacySettingsData(titleText: "Location",perrmissionType: .LocationPermission)]
    
    func addObserver(){

        NotificationCenter.default.addObserver(self, selector: #selector(updateSettings), name: Notification.Name("appDidBecomeActive"), object: nil)
    }
    
    @objc func updateSettings(){
      print("blVLlvals")
    }
    
//    func cameraPermissionChanged(){
//        let status = AVCaptureDevice.authorizationStatus(for: .video)
//
//        switch status {
//        case .authorized,.notDetermined:
//            print("switch i aktif")
//        case .denied,.restricted:
//            print("switch i pasif")
//        default:
//            print("switch i pasif")
//        }
//    }
    
//    func addPhotoLibraryPermissionObserver() {
//        PHPhotoLibrary.requestAuthorization { status in
//            switch status {
//            case .authorized:
//                print("Fotoğraf kütüphanesi izni verildi.")
//            case .denied, .restricted:
//                print("Fotoğraf kütüphanesi izni reddedildi veya kısıtlandı.")
//            case .notDetermined:
//                print("Fotoğraf kütüphanesi izni daha önce verilmemiş.")
//            default:
//                break
//            }
//        }
//    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: Notification.Name("appDidBecomeActive"), object: nil)
//    }

    
    func requestPermissions(){
        PermissionsHelper.shared.requestCameraPermission()
        PermissionsHelper.shared.requestPhotoLibraryPermission()
        PermissionsHelper.shared.requestLocationPermission()
    }
}
