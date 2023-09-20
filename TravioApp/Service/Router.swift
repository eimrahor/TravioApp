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
    
    case register(params: Parameters), userLogin(params: Parameters), refreshToken(params: Parameters), getUserProfile, listVisits, getVisitWithID(id: String), getAllGalleryImagesWithID(id: String), getAllPlaces,upload(imageDatas:[Data]),addNewPlace(params:Parameters),getPlaceByID(id: String), postGalleryImage(params:Parameters), getPopularPlaces(params: Parameters), getLastPlaces(params: Parameters), getAllPopularPlaces, getAllLastPlaces, checkVisitByPlaceID(id: String), deleteAVisitByPlaceID(id: String), postAVisit(params: Parameters), changePassword(params: Parameters), editProfile(params:Parameters)
    
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
        case .getPlaceByID(let id):
            return "/v1/places/\(id)"
        case .getVisitWithID(let id):
            return "/v1/visits/\(id)"
        case .getAllGalleryImagesWithID(let id):
            return "/v1/galleries/\(id)"
        case .upload:
            return "/upload"
        case .postGalleryImage:
            return "/v1/galleries"
        case .getPopularPlaces, .getAllPopularPlaces:
            return "/v1/places/popular"
        case .getLastPlaces, .getAllLastPlaces:
            return "/v1/places/last"
        case .checkVisitByPlaceID(let id):
            return "/v1/visits/user/\(id)"
        case .deleteAVisitByPlaceID(let id):
            return "/v1/visits/\(id)"
        case .postAVisit:
            return "/v1/visits"
        case .changePassword:
            return "/v1/change-password"
        case .editProfile(params: let params):
            return "/v1/edit-profile"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUserProfile, .listVisits, .getVisitWithID, .getAllGalleryImagesWithID, .getAllPlaces, .getPlaceByID, .getPopularPlaces, .getLastPlaces ,.getAllPopularPlaces, .getAllLastPlaces, .checkVisitByPlaceID: return .get
        case .register, .userLogin, .refreshToken, .upload, .addNewPlace, .postGalleryImage, .postAVisit: return .post
        case .changePassword, .editProfile: return .put
        case .deleteAVisitByPlaceID: return .delete
        }
    }
     
    var headers: HTTPHeaders {
        switch self {
        case .listVisits, .getUserProfile, .getVisitWithID, .getAllGalleryImagesWithID, .addNewPlace, .postGalleryImage, .checkVisitByPlaceID, .deleteAVisitByPlaceID, .postAVisit, .changePassword, .editProfile: return headersAllcases ?? [:]
        case .upload : return ["Content-Type":"multipart/form-data"]
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
        case .register(let params), .userLogin(let params), .refreshToken(let params), .addNewPlace(let params), .postGalleryImage(let params), .getPopularPlaces(let params), .getLastPlaces(let params), .postAVisit(let params), .changePassword(let params), .editProfile(let params): return params
        default: return [:]
        }
    }
    
    var multiPartFormData:MultipartFormData{
        
        let multipartFormData = MultipartFormData()
        switch self{
        case .upload(imageDatas: let data):
            for imageData in data {
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        default:
            break
        }
        return multipartFormData
    }
    
    var encoding: ParameterEncoding? {
        switch self.method {
        case .get, .delete: return URLEncoding.default
        case .post, .put: return JSONEncoding.default
        default:
            return nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        guard let encoding = encoding else { return try URLRequest(url: "", method: .get) }
        request = try (encoding.encode(request, with: params))
        return request
    }
}
