//
//  UserRegisterVM.swift
//  ContinueAPI
//
//  Created by Kurumsal on 22.08.2023.
//

import Foundation
import Alamofire

class UserRegisterVM {
    
    var showAlert:((ErrorTypes)->(Void))?
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
    func checkCanSignUp(name:String,email:String,password:String,passwordConfirm:String)->Bool{
       
        guard let showAlert = showAlert else {return false}
        
        if name == "" || email == "" {
            //show alert
            showAlert(.nameOrMailEmpty)
            return false}
        
        if password != passwordConfirm{
            //Show alert
            showAlert(.passwordsDoesntMatch)
            return false }
        
        if password.count < 6 {
            //show alert
            showAlert(.passwordsLessThanRequiredChar)
            return false}
        
        return true
    }
}


