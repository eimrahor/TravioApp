//
//  PrivacySettingsCellVM.swift
//  TravioApp
//
//  Created by Elif Poyraz on 10.09.2023.
//

import Foundation
import Photos
import AVFoundation

class PrivacySettingsCellVM{
    
    var permissionType:PermissionType?
    
    var sendSwitchStateToVC:((Bool)->(Void))?
    
    var switchState:Bool?{
        didSet{
            guard let switchState = switchState , let sendSwitchStateToVC = sendSwitchStateToVC else {return}
            sendSwitchStateToVC(switchState)
        }
    }
    
    func addObserver(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSettings), name: Notification.Name("appDidBecomeActive"), object: nil)
    }
    
    @objc func updateSettings(){
        
        print("1 girdi")
        switch permissionType {
            
            case .CameraPermission:
                cameraPermissionChanged()
                
            case .PhotoLibraryPermission:
                photoLibraryPermissionChanged()
                
            case .LocationPermission:
                locationPermissionChanged()
            case .none:
                return
        }
    }
    
    func cameraPermissionChanged(){
        print("2 girdi")
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        switch status {
        case .authorized,.notDetermined:
            switchState = true
        case .denied,.restricted:
            switchState = false
        default:
            switchState = false
        }
    }
    
    func photoLibraryPermissionChanged() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                self.switchState = true
            case .denied, .restricted:
                self.switchState = false
            case .notDetermined:
                self.switchState = false
            default:
                break
            }
        }
    }
    
    func locationPermissionChanged(){
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("appDidBecomeActive"), object: nil)
    }
}
