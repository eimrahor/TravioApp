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
import CoreLocation

class SecuritySettingsVM {
    
    //MARK: closure for reload tableview data when privacySettings switchStates changed.
    var reloadClosure:(()->())?
    var passwordSettingsDatas:[PasswordSettingsData] = [PasswordSettingsData(titleText: "New Password", placeHolderText: "********"),PasswordSettingsData(titleText: "New Password Confirm", placeHolderText: "********")]
    
    var privacySettingsDatas:[PrivacySettingsData] = [PrivacySettingsData(titleText: "Camera",perrmissionType: .CameraPermission),PrivacySettingsData(titleText: "Photo Library",perrmissionType: .PhotoLibraryPermission),PrivacySettingsData(titleText: "Location",perrmissionType: .LocationPermission)]
    
    //MARK: add observer for update privacy settings
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateSettings), name: Notification.Name("appDidBecomeActive"), object: nil)
    }
    
    @objc func updateSettings(){
        cameraPermissionChanged()
        photoLibraryPermissionChanged()
        locationPermissionChanged()
        reloadClosure?()
    }
    
    //MARK: for camera permission
    func cameraPermissionChanged(){
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        switch status {
        case .authorized:
            privacySettingsDatas[0].switchState = true
        case .denied,.restricted,.notDetermined:
            privacySettingsDatas[0].switchState = false
        default:
            privacySettingsDatas[0].switchState = false
        }
    }
    
    //MARK: for photoLibrary permission
    func photoLibraryPermissionChanged() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                self.privacySettingsDatas[1].switchState = true
            case .notDetermined, .denied, .restricted:
                self.privacySettingsDatas[1].switchState = false
            default:
                break
            }
        }
    }
    
    //MARK: for location permission
    func locationPermissionChanged() {
        let permissionStatus = PermissionsHelper.shared.locationManager.authorizationStatus
       
            if permissionStatus == .authorizedWhenInUse || permissionStatus == .authorizedAlways {
                self.privacySettingsDatas[2].switchState = true
            } else {
                self.privacySettingsDatas[2].switchState = false
            }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("appDidBecomeActive"), object: nil)
    }

    //MARK: first request for using camera, library, location.
    func requestPermissions(){
        PermissionsHelper.shared.requestCameraPermission()
        PermissionsHelper.shared.requestPhotoLibraryPermission()
        PermissionsHelper.shared.requestLocationPermission()
    }
    
    func savePasswordToAPI(params: [String:Any]) {
        
        APIService.call.objectRequestJSON(request: Router.changePassword(params: params)) { (result:Result<ChangePasswordResponse,Error>) in
            switch result {
            case .success(let response):
                print(response.message)
            case .failure(let err):
                print(err)
            }
        }
    }
}
