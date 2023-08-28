//
//  UserRegisterVM.swift
//  ContinueAPI
//
//  Created by Kurumsal on 22.08.2023.
//

import Foundation
import Alamofire

class UserRegisterVM {
    
    func postForRegisterData(params: [String:Any]) {
        
        APIService.call.objectRequestJSON(request: Router.register(params: params)) { (result:Result<UserRegisterResponse,Error>) in
            switch result {
            case .success(_):
                print("register gerçekleşti")
            case .failure(let err):
                print(err)
            }
        }
    }
    
}


