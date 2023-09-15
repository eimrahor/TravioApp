//
//  DetailVisitsViewModel.swift
//  ContinueAPI
//
//  Created by Kurumsal on 22.08.2023.
//

import Foundation
import Alamofire

class DetailVisitsViewModel {
    
    var placeId: String?
    var imagesData: GetGalleryImages?
    
    init(placeId: String) {
        self.placeId = placeId
    }

    func getAPlaceById(complete: @escaping (Place)->()) {
        guard let placeId = placeId else { return }
        APIService.call.objectRequestJSON(request: Router.getPlaceByID(id: placeId)) { (result:Result<GetAPlaces,Error>) in
            switch result {
            case .success(let data):
                complete(data.data.place)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getAllGalleryImages(complete: @escaping ()->()) {
        guard let placeId = placeId else { return }
        
        APIService.call.objectRequestJSON(request: Router.getAllGalleryImagesWithID(id: placeId) ) { (result:Result<GetGalleryImages,Error>) in
            switch result {
            case .success(let data):
                self.imagesData = data
                complete()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func checkVisitByPlaceID(complete: @escaping (Bool)->()) {
        guard let placeId = placeId else { return }
        
        APIService.call.objectRequestJSON(request: Router.checkVisitByPlaceID(id: placeId)) { (result:Result<DetailVisitsModel,Error>) in
            switch result {
            case .success(let response):
                if response.status == "success" {
                    //self.deleteAVisitByPlaceID()
                    complete(true)
                } else {
                    //self.postAVisit()
                    complete(false)
                }
            case .failure(_):
                print("err json")
            }
        }
    }
    
    func deleteAVisitByPlaceID() {
        guard let placeId = placeId else { return }
        
        APIService.call.objectRequestJSON(request: Router.deleteAVisitByPlaceID(id: placeId)) { (result:Result<DeleteAVisit,Error>) in
            switch result {
            case .success(let data):
                print(data)
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
    
    func takeFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let today = Date()
        let formattedDate = dateFormatter.string(from: today)

        return formattedDate
    }
    
    func returnGalleryImage(row: Int) -> Image {
        guard let imagesData = imagesData else { return Image(id: "", place_id: "", image_url: "", created_at: "", updated_at: "") }
        return imagesData.data.images[row]
    }
    
    func galleryImagesDataCount() -> Int {
        guard let imagesData = imagesData else { return 0 }
        return imagesData.data.count
    }
    
    
}
