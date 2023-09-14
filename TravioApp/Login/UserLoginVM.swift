//
//  UserViewModel.swift
//  ContinueAPI
//
//  Created by Kurumsal on 17.08.2023.
//

import Foundation

class UserLoginVM {
    
    var user = User(full_name: "asdfgrgt", email: "747172@gmail.com", password: "123123123")
    var takeUsersArr: ((User)->Void)?
    
    
    func prepareKeyChain() {
            let data = Data((self.user.accessToken!.utf8))
            KeyChainHelper.shared.saveKey(data, service: "access-token-0", account: "ios")
    }
    
    func postForUserLogin(params: [String:Any], callback: @escaping ()->Void) {
        
        APIService.call.objectRequestJSON(request: Router.userLogin(params: params)) { (result:Result<UserLoginResponse,Error>) in
            switch result {
            case .success(let data):
                self.user.accessToken = data.accessToken
                self.prepareKeyChain()
                callback()
            case .failure(let err):
                print(err)
            }
        }
    }
}
