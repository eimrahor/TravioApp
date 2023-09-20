//
//  UserViewModel.swift
//  ContinueAPI
//
//  Created by Kurumsal on 17.08.2023.
//

import Foundation

class UserLoginVM {
    
    var showAlert:((ErrorTypes)->())?
    var user: User?
    var takeUsersArr: ((User)->Void)?
    
    
    func prepareKeyChain() {
        guard let accessToken = user?.accessToken, let refreshToken = user?.refreshToken else { return }
        let dataAccess = Data((accessToken.utf8))
        let dataRefresh = Data((refreshToken.utf8))
        user = nil
        KeyChainHelper.shared.saveKey(dataAccess, service: "access-token-0", account: "ios")
        KeyChainHelper.shared.saveKey(dataRefresh, service: "refresh-token-0", account: "ios")
    }
    
    func postForUserLogin(params: [String:Any], callback: @escaping ()->Void) {
        guard let email = params["email"] as? String, let password = params["password"] as? String else { return }
        user = User(email: email, password: password, accessToken: "", refreshToken: "")
        
        APIService.call.objectRequestJSON(request: Router.userLogin(params: params)) { [self] (result:Result<UserLoginResponse,Error>) in
            switch result {
            case .success(let data):
                user?.accessToken = data.accessToken
                user?.refreshToken = data.refreshToken
                self.prepareKeyChain()
                callback()
            case .failure(let err):
                guard let showAlert = self.showAlert else {return}
                showAlert(.APIError(err))
                print(err)
                
            }
        }
    }
    
    
}
