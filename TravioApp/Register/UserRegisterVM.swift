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
    var showSuccesfullyRegisterAlert:((String)->(Void))?
    
    func postForRegisterData(user:User) {
        
        let params:[String:Any] = [
            "full_name":user.fullName,
            "email":user.email,
            "password":user.password
        ]
        APIService.call.objectRequestJSON(request: Router.register(params: params)) { (result:Result<UserRegisterResponse,Error>) in
            switch result {
            case .success(let response):
                guard let succesAlert = self.showSuccesfullyRegisterAlert else {return}
                succesAlert(response.message)
                print("register gerçekleşti")
            case .failure(let err):
                print(err)
            }
        }
    }
    func checkCanSignUp(name:String,email:String,password:String,passwordConfirm:String)->Bool{
        
        let passwordRegex = "^(?=.*\\d)(?=.*[A-Z])(?=.*[a-z])(?=\\S+$).{6,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let isPasswordValid = passwordTest.evaluate(with: password)
        
        guard let showAlert = showAlert else {return false}
        
        if name == "" || email == "" {
            showAlert(.nameOrMailEmpty)
            return false}
        
        if password != passwordConfirm{
            showAlert(.passwordsDoesntMatch)
            return false }
        
        if !isPasswordValid {
            showAlert(.passwordsLessThanRequiredChar)
            return false}
        
        return true
    }
}


