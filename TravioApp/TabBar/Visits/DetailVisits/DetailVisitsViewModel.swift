//
//  DetailVisitsViewModel.swift
//  ContinueAPI
//
//  Created by Kurumsal on 22.08.2023.
//

import Foundation
import Alamofire

class DetailVisitsViewModel {
    
    var dGroup: DispatchGroup?
    var visitId: String?
    var placeId: String?
    var backDataGalleryImagesClosure: ((GetGalleryImages)->())?
    var backDataTravelClosure: ((GetVisit)->())?
    
    init(visitId: String, placeId: String) {
        self.visitId = visitId
        self.placeId = placeId
        getTravelByID()
        getAllGalleryImages()
    }
    
    func takeFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let today = Date()
        let formattedDate = dateFormatter.string(from: today)

        return formattedDate
    }
    
    func getTravelByID() {
        guard let visitId = visitId else { return }

        APIService.call.objectRequestJSON(request: Router.getVisitWithID(id: visitId)) { [self] (result:Result<GetVisit,Error>) in
            switch result {
            case .success(let data):
                print("TRAVELDATA:   \(data)")
                self.backDataTravelClosure?(data)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
    func getAllGalleryImages() {
        guard let placeId = placeId else { return }
        
        APIService.call.objectRequestJSON(request: Router.getAllGalleryImagesWithID(id: placeId) ) { (result:Result<GetGalleryImages,Error>) in
            switch result {
            case .success(let data):
                self.backDataGalleryImagesClosure?(data)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func checkVisitByPlaceID(complete: @escaping (Bool)->()) {
        guard let placeId = placeId else { return }
        
        APIService.call.objectRequestJSON(request: Router.checkVisitByPlaceID(id: placeId)) { (result:Result<DetailVisitsModel,Error>) in
            switch result {
            case .success(_):
                self.dGroup?.enter()
                
                self.deleteAVisitByPlaceID() {
                    self.dGroup?.leave()
                }
                complete(true)
            case .failure(_):
                self.postAVisit()
                complete(false)
            }
        }
    }
    
    func deleteAVisitByPlaceID(complete: @escaping ()->()) {
        guard let placeId = placeId else { return }
        
        APIService.call.objectRequestJSON(request: Router.deleteAVisitByPlaceID(id: placeId)) { (result:Result<DeleteAVisit,Error>) in
            switch result {
            case .success(let data):
                print(data)
                complete()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postAVisit() {
        guard let placeId = placeId else { return }
        let params = [
            "place_id" : placeId,
            "visited_at" : takeFormattedDate()
        ]
        
        APIService.call.objectRequestJSON(request: Router.postAVisit(params: params)) { (result:Result<PostAVisit,Error>) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
}
