//
//  CustomViewController.swift
//  TravioApp
//
//  Created by imrahor on 8.09.2023.
//

import Foundation
import UIKit
import Photos

class CustomUIViewSwitchControl: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: Notification.Name("CustomNotification"), object: nil)
    }
    
    @objc func handleNotification() {
        requestPhotoLibraryPermission()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                // Kullanıcı izin verdi, fotoğraf kütüphanesine erişebilirsiniz.
                print("Kullanıcı izin verdi.")
            case .denied, .restricted:
                // Kullanıcı izin vermedi veya kısıtlı erişime sahip.
                print("Kullanıcı izin vermedi veya kısıtlı erişime sahip.")
            case .notDetermined:
                // Kullanıcı henüz bir seçim yapmadı.
                print("Kullanıcı henüz bir seçim yapmadı.")
            @unknown default:
                break
            }
        }
    }
    
    deinit {
        print("deinit çalıştı")
        NotificationCenter.default.removeObserver(self)
    }
}
