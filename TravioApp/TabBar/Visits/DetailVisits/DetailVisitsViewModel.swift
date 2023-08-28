//
//  DetailVisitsViewModel.swift
//  ContinueAPI
//
//  Created by Kurumsal on 22.08.2023.
//

import Foundation
import Alamofire

class DetailVisitsViewModel {
    
    var travelId: String?
    var backDataGalleryImagesClosure: ((GetGalleryImages)->())?
    var backDataTravelClosure: ((GetPlace)->())?
    
    init(travelId: String) {
        self.travelId = travelId
        getTravelByID()
        getAllGalleryImages()
    }
    
    var headers: HTTPHeaders? {
        guard let data = KeyChainHelper.shared.readKey(service: "access-token-0", account: "ios") else {  return nil }
        guard let tokenObject = String(data: data, encoding: .utf8) else { return nil}
        let header:HTTPHeaders = [
            "Authorization": "Bearer \(tokenObject)",
            "Accept": "application/json"
        ]
        return header
    }
    
    func getTravelByID() {
        guard let placeId = travelId else { return }

        APIService.call.objectRequestJSON(request: Router.getPlaceWithID(id: placeId)) { [self] (result:Result<GetPlace,Error>) in
            switch result {
            case .success(let data):
                print(data)
                self.backDataTravelClosure?(data)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
    func getAllGalleryImages() {
        guard let travelId = travelId else { return }
        
        APIService.call.objectRequestJSON(request: Router.getAllGalleryImagesWithID(id: travelId) ) { (result:Result<GetGalleryImages,Error>) in
            switch result {
            case .success(let data):
                print(data)
                self.backDataGalleryImagesClosure?(data)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
}
