//
//  APIService.swift
//  ContinueAPI
//
//  Created by Kurumsal on 17.08.2023.
//

import Foundation
import Alamofire
import UIKit

class APIService {
    static let call = APIService()

    func objectRequestJSON<T:Codable>(request: URLRequestConvertible, complete: @escaping (Result<T,Error>)->Void) {
        
        let responseInterceptor = AccessTokenInterceptor()
            AF.request(request, interceptor: responseInterceptor).responseJSON { response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data)
                        let decodedData = try JSONDecoder().decode(T.self,from: jsonData)
                        complete(.success(decodedData))
                    } catch {
                        complete(.failure(error))
                    }
                case .failure(_):
                    print("error")
                }
            }
    }
    
    func uploadImagesToServer<T:Codable>(route:Router, completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        AF.upload(multipartFormData: route.multiPartFormData, with: route)
        .responseJSON{ response in
            switch response.result {
            case .success(let value):
                do {
                   let jsonData = try JSONSerialization.data(withJSONObject: value)
                   let decodedData = try JSONDecoder().decode(T.self,from: jsonData)
                    completionHandler(.success(decodedData))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

