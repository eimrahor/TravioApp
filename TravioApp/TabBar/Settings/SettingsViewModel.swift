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
    
    var sendUserDataToVC:((UserProfile)->())?
    
    var user:UserProfile?{
        didSet{
            guard let sendUserDataToVC = sendUserDataToVC , let user = user else { return }
            sendUserDataToVC(user)
        }
    }
    
    func countofArr() -> Int {
        return arr.count
    }
    
    func getUserProfile(){
        
        APIService.call.objectRequestJSON(request: Router.getUserProfile){ (result:Result<UserProfile,Error>) in
            
            switch result {
            case .success(let profile):
                self.user = profile
            case .failure(let error):
                print(error)
            }
        }
    }
}
