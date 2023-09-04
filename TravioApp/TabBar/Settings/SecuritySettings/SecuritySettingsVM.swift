//
//  SecuritySettingsVM.swift
//  TravioApp
//
//  Created by Kurumsal on 1.09.2023.
//

import Foundation


class SecuritySettingsVM{
    
    var passwordSettingsDatas:[PasswordSettingsData] = [PasswordSettingsData(titleText: "New Password", placeHolderText: "********"),PasswordSettingsData(titleText: "New Password Confirm", placeHolderText: "********"),PasswordSettingsData(titleText: "New Password", placeHolderText: "********"),PasswordSettingsData(titleText: "New Password Confirm", placeHolderText: "********")]
    
    var privacySettingsDatas:[PrivacySettingsData] = [PrivacySettingsData(titleText: "Camera", switchState: true),PrivacySettingsData(titleText: "Photo Library", switchState: false),PrivacySettingsData(titleText: "Location", switchState: true)]
}
