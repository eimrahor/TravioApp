//
//  AccessTokenManager.swift
//  TravioApp
//
//  Created by imrahor on 16.09.2023.
//

import Foundation
import Alamofire

class AccessTokenInterceptor: RequestInterceptor {
    
    private func getParam() -> Parameters? {
        
        guard let data = KeyChainHelper.shared.readKey(service: "refresh-token-0", account: "ios") else {  return nil }
        guard let tokenObject = String(data: data, encoding: .utf8) else { return nil}
        let params:Parameters = [
            "refresh_token": tokenObject
        ]
        return params
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
        guard request.retryCount < 2 else {
            completion(.doNotRetry)
            return
        }
        guard let params = getParam() else { return }
        APIService.call.objectRequestJSON(request: Router.refreshToken(params: params)) { (result:Result<UserLoginResponse,Error>) in
            switch result {
            case .success(let response):
                let data: Data = response.accessToken.data(using: .utf8)!
                KeyChainHelper.shared.saveKey(data, service: "access-token-0", account: "ios")
                completion(.retry)
            case .failure:
                completion(.doNotRetry)
            }
        }
    }
}

