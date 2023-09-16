//
//  UserRegisterVM.swift
//  ContinueAPI
//
//  Created by Kurumsal on 22.08.2023.
//

import Foundation
import Alamofire

class UserRegisterVM {
    
   // var showAlert:(()->())?
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
       
        if name == "" || email == "" {
            //show alert
          //  showAlert(title: "eror2", err: "blabla")
            return false}
        
        if password != passwordConfirm{
            //Show alert
         //   showAlert(title: "eror3", err: "blabla")
            return false }
        
        if password.count < 6 {
            //show alert
          //  showAlert(title: "eror4", err: "blabla")
            return false}
        
        return true
    }
}


