//
//  APIService.swift
//  ContinueAPI
//
//  Created by Kurumsal on 17.08.2023.
//

import Foundation
import Alamofire
import UIKit

enum Endpoint {
    static let baseUrl = "https://api.iosclass.live"
    
    case register
    case userLogin
    case refreshToken
    case getUserProfile
    case listTravel
    case getTravelByID
    case getAllGalleryImages
    
    var apiurl : String {
        switch self {
        case .register:
            return Endpoint.baseUrl + "/v1/auth/register"
        case .userLogin:
            return Endpoint.baseUrl + "/v1/auth/login"
        case .refreshToken:
            return Endpoint.baseUrl + "/v1/auth/refresh"
        case .getUserProfile:
            return Endpoint.baseUrl + "/v1/me"
        case .listTravel:
            return Endpoint.baseUrl + "/v1/travels?page=1&limit=10"
        case .getTravelByID:
            return Endpoint.baseUrl + "/v1/travels/"
        case .getAllGalleryImages:
            return Endpoint.baseUrl + "/v1/galleries/"
        }
    }
}

class APIService {
    static let call = APIService()
    
//    func objectRequestJSON<T:Codable>(from apiUrl: String, params:Parameters,headers: HTTPHeaders, method:HTTPMethod, complete: @escaping (Result<T,Error>)->Void) {
//
//        if T.Type.self == GetUserInfoResponse.Type.self || T.Type.self == ListTravelsResponse.Type.self || T.Type.self == GetTravel.Type.self || T.Type.self == GetGalleryImages.Type.self {
//            AF.request(apiUrl, method: method, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let jsonData = try JSONSerialization.data(withJSONObject: data)
//                        let decodedData = try JSONDecoder().decode(T.self,from: jsonData)
//                        complete(.success(decodedData))
//                    } catch {
//                        complete(.failure(error))
//                    }
//                case .failure(let err):
//                    complete(.failure(err))
//                }
//            }
//        } else {
//
//
//            AF.request(apiUrl, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let jsonData = try JSONSerialization.data(withJSONObject: data)
//                        let decodedData = try JSONDecoder().decode(T.self,from: jsonData)
//                        complete(.success(decodedData))
//                    } catch {
//                        complete(.failure(error))
//                    }
//                case .failure(let err):
//                    complete(.failure(err))
//                }
//            }
//        }
//    }
    
    func objectRequestJSON<T:Codable>(request: URLRequestConvertible, complete: @escaping (Result<T,Error>)->Void) {
        DispatchQueue.global(qos: .utility).async {
            AF.request(request).responseJSON { response in
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
                    
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
//    func uploadImagesToServer<T:Codable>(images: [UIImage], url: String, completionHandler: @escaping (Result<T, Error>) -> Void) {
//        AF.upload(
//            multipartFormData: { multipartFormData in
//
//                for image in images {
//                    if let imageData = image.jpegData(compressionQuality: 0.5) {
//                        multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
//                    }
//                }
//            },
//            to: url , method: .post
//        ).responseJSON{ response in
//            switch response.result {
//            case .success(let value):
//                do {
//                   let jsonData = try JSONSerialization.data(withJSONObject: value)
//                   let decodedData = try JSONDecoder().decode(T.self,from: jsonData)
//                    completionHandler(.success(decodedData))
//                } catch {
//
//                }
//
//            case .failure(let error):
//                completionHandler(.failure(error))
//            }
//        }
//    }
    
}

