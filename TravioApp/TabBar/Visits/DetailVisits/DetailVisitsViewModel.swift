//
//  DetailVisitsViewModel.swift
//  ContinueAPI
//
//  Created by Kurumsal on 22.08.2023.
//

import Foundation
import Alamofire

class DetailVisitsViewModel {
    
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
    
    
}
