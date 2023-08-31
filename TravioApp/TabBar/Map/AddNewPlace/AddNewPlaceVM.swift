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
    
    var requesVMToUpdatePlace: (()->())?
    var selectedImageUrls:[String]?
   
    
    func initVM(place:PlaceToMap){
        
        self.place = PlaceToMap()
        if let cityCountryUnWrap = place.place { self.place?.place = cityCountryUnWrap}
        if let latitudeUnWrap = place.latitude { self.place?.latitude = latitudeUnWrap}
        if let longitudeUnWrap = place.longitude { self.place?.longitude = longitudeUnWrap}
    }
    
    func sendImagesToServer(selectedImages:[UIImage]?){
        
            if let images = selectedImages{
            let serverURL = "https://api.iosclass.live/upload"
            
                APIService.call.uploadImagesToServer(images: images, url: serverURL) { (result:Result<UploadImageResponse,Error>) in
                switch result {
                case .success(let response):
                    print("Response: \(response)")
                    print("Response: \(response.urls.first)")
                    // url leri alınca bu diziye at selectedimgurls
                    guard let requestToUpdatePlace = self.requesVMToUpdatePlace else{return}
                    requestToUpdatePlace()
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }

   
    func updateVMPlaceData(placeName:String,placeDescription:String,placeCountryCity:String)
    {
        place?.title = placeName
        place?.description = placeDescription
        place?.place = placeCountryCity
    }
    
//    func addNewPlaceToServer(){
//
//        guard let placeUnWrapped = place else { return }
//        guard let placeCountryCity = placeUnWrapped.place, let title = placeUnWrapped.title, let description = placeUnWrapped.description,let over_image_url = selectedImageUrls?[0],let latitude = placeUnWrapped.latitude,let longitude = placeUnWrapped.longitude) else { return }
//
//        let params:[String:Any] = ["place":]
//
//        APIService.call.objectRequestJSON(request: Router.addNewPlace(params: )) { (result:Result<UserLoginResponse,Error>) in
//            switch result {
//            case .success(let data):
//                self.user.accessToken = data.accessToken
//                self.createKeyChain?()
//            case .failure(let err):
//                print(err)
//            }
//        }
//    }
    
    
}
