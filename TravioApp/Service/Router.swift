////
////  Router.swift
////  ContinueAPI
////
////  Created by Kurumsal on 23.08.2023.
////
//
import Foundation
import Alamofire
import UIKit

public enum Router: URLRequestConvertible {
    
    case register(params: Parameters), userLogin(params: Parameters), refreshToken(params: Parameters), getUserProfile, listVisits, getVisitWithID(id: String), getAllGalleryImagesWithID(id: String), getAllPlaces,addNewPlace(params:Parameters)
    
    var baseURL: URL {
        return URL(string: "https://api.iosclass.live")!
    }
    
    var path: String {
        switch self {
        case .register:
            return "/v1/auth/register"
        case .userLogin:
            return "/v1/auth/login"
        case .refreshToken:
            return "/v1/auth/refresh"
        case .getUserProfile:
            return "/v1/me"
        case .listVisits:
            return "/v1/visits"
        case .getAllPlaces, .addNewPlace:
            return "/v1/places"
        case .getVisitWithID(let id):
            return "/v1/visits/\(id)"
        case .getAllGalleryImagesWithID(let id):
            return "/v1/galleries/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUserProfile, .listVisits, .getVisitWithID, .getAllGalleryImagesWithID, .getAllPlaces: return .get
        case .register, .userLogin, .refreshToken,.addNewPlace: return .post
        }
    }
     
    var headers: HTTPHeaders {
        switch self {
        case .listVisits, .getUserProfile, .getVisitWithID, .getAllGalleryImagesWithID, .addNewPlace : return headersAllcases ?? [:]
        default:
            return [:]
        }
    }
    
    var headersAllcases: HTTPHeaders? {
        guard let data = KeyChainHelper.shared.readKey(service: "access-token-0", account: "ios") else {  return nil }
        guard let tokenObject = String(data: data, encoding: .utf8) else { return nil}
        let header:HTTPHeaders = [
            "Authorization": "Bearer \(tokenObject)",
            "Accept": "application/json"
        ]
        return header
    }
    
    var params: Parameters {
        switch self {
        case .register(let params), .userLogin(let params), .refreshToken(let params), .addNewPlace(let params): return params
        default: return [:]
        }
    }
    
    var encoding: ParameterEncoding? {
        switch self.method {
        case .get: return URLEncoding.default
        case .post: return JSONEncoding.default
        default:
            return nil
        }
    }
    
    
    public func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        request = try (encoding?.encode(request, with: params))!
        
        return request
    }
}
