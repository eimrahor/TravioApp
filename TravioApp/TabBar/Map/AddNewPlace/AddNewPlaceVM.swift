//
//  AddNewPlaceVM.swift
//  TravioApp
//
//  Created by Kurumsal on 28.08.2023.
//

import Foundation
import UIKit
import Alamofire

class AddNewPlaceVM{
    
    var place:PlaceToMap?
    var placeID:String?
    
    // MARK: Closure for get place's new datas from AddNewPlaceVC when sending images to server was finished.
    var requesVMToUpdatePlace: (()->())?
    var imageUrls:[String]?
   
    // MARK: get location,city,country data from MapVC annotation.
    func initVM(place:PlaceToMap){
        
        self.place = PlaceToMap()
        if let cityCountryUnWrap = place.place { self.place?.place = cityCountryUnWrap}
        if let latitudeUnWrap = place.latitude { self.place?.latitude = latitudeUnWrap}
        if let longitudeUnWrap = place.longitude { self.place?.longitude = longitudeUnWrap}
    }
    
    // MARK: get name,description,place from AddNewPlaceVC.
    func updateVMPlaceData(placeName:String,placeDescription:String,placeCountryCity:String)
    {
        place?.title = placeName
        place?.description = placeDescription
        place?.place = placeCountryCity
    }
    
    // MARK: send imagesData to server.
    func sendImagesToServer(selectedImages:[UIImage]?){
        
        guard let selectedImages = selectedImages else {return}
        
        let imageDatas = convertUIImagesToData(images: selectedImages)
            
        APIService.call.uploadImagesToServer(route: .upload(imageDatas: imageDatas)) { (result:Result<UploadImageResponse,Error>) in
            switch result {
            case .success(let response):
                
                print("Response: \(response)")
                
                guard let requestToUpdatePlace = self.requesVMToUpdatePlace else{return}
                requestToUpdatePlace()
                
                self.addNewPlaceToServer()
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    // MARK: convert UIImages array to Data array.
    func convertUIImagesToData(images:[UIImage]) -> [Data] {
        
        var imageDatas = [Data]()
        
        for image in images {
            if let data = image.jpegData(compressionQuality: 0.5) {
                imageDatas.append(data)
            }
        }
        return imageDatas
    }
    
    // MARK: extract image urls to imageUrls array.
    func extractImageURLsToArray(response:UploadImageResponse){
        imageUrls = [String]()
        let urls = response.urls
        
        for url in urls {
            imageUrls?.append(url)
        }
    }
    

    func addNewPlaceToServer(){

        guard let place = place else { return }
        guard let placeCountryCity = place.place,
              let title = place.title,
              let description = place.description,
              let cover_image_url = imageUrls?[0],
              let latitude = place.latitude,
              let longitude = place.longitude
        else { return }

        let params:[String:Any] = ["place":"\(placeCountryCity)","title":"\(title)","description":"\(description)","cover_image_url":"\(cover_image_url)","latitude":"\(latitude)","longitude":"\(longitude)"]

        APIService.call.objectRequestJSON(request: Router.addNewPlace(params: params )) { (result:Result<PostPlacesResponse,Error>) in
            switch result {
            case .success(let response):
                self.placeID = response.message
                print(self.placeID)
            case .failure(let err):
                print(err)
            }
        }
    }
}


