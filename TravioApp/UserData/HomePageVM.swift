//
//  HomePageVM.swift
//  ContinueAPI
//
//  Created by imrahor on 17.08.2023.
//

import Foundation
import Alamofire

class HomePageVM {
    
    func getUserProfile() {
        APIService.call.objectRequestJSON(request: Router.getUserProfile) { (result:Result<GetUserInfoResponse,Error>) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let err):
                print(err)
            }
        }
    }
}
