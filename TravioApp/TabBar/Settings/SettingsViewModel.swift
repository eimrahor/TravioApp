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
                Settings(icon: "vector1", label: "App Defaults",targetVC: AppDefaultVC()),
                Settings(icon: "vector2", label: "My Added Places",targetVC: SeeAllVC()),
                Settings(icon: "vector3", label: "Help&Support",targetVC: HelpAndSupportVC()),
                Settings(icon: "vector4", label: "About",targetVC: AboutVC()),
                Settings(icon: "vector5", label: "Terms of Use",targetVC: TermsOfUseVC())]
    
    func countofArr() -> Int {
        return arr.count
    }
}
