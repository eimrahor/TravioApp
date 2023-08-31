//
//  SettingsViewModel.swift
//  TravioApp
//
//  Created by imrahor on 31.08.2023.
//

import Foundation

struct Settings {
    var icon: String
    var label: String
}

class SettingsViewModel {
    
    let arr = [ Settings(icon: "user-alt", label: "Security Settings"),
                Settings(icon: "vector1", label: "App Defaults"),
                Settings(icon: "vector2", label: "My Added Places"),
                Settings(icon: "vector3", label: "Help&Support"),
                Settings(icon: "vector4", label: "About"),
                Settings(icon: "vector5", label: "Terms of Use")]
    
    func countofArr() -> Int {
        return arr.count
    }
}
