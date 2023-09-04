//
//  SettingsViewModel.swift
//  TravioApp
//
//  Created by imrahor on 31.08.2023.
//

import Foundation
import UIKit

struct Settings {
    var icon: String
    var label: String
    var targetVC: UIViewController
}

class SettingsViewModel {
    
    let arr = [ Settings(icon: "user-alt", label: "Security Settings",targetVC: SecuritySettingsVC()),
                Settings(icon: "vector1", label: "App Defaults",targetVC: SecuritySettingsVC()),
                Settings(icon: "vector2", label: "My Added Places",targetVC: SecuritySettingsVC()),
                Settings(icon: "vector3", label: "Help&Support",targetVC: SecuritySettingsVC()),
                Settings(icon: "vector4", label: "About",targetVC: SecuritySettingsVC()),
                Settings(icon: "vector5", label: "Terms of Use",targetVC: SecuritySettingsVC())]
    
    func countofArr() -> Int {
        return arr.count
    }
}
