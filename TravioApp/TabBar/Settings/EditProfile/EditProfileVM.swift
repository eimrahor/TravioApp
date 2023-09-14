//
//  EditProfileVM.swift
//  TravioApp
//
//  Created by Elif Poyraz on 10.09.2023.
//

import Foundation
import AVFoundation
import UIKit
import Alamofire

class EditProfileVM{
    
    var userProfile:UserProfile?
    var profileImage:UIImage?
    var imageUrls:[String]?
    
    func sendImagesToServer(image:[UIImage]?, complete: @escaping (Result<String, Error>) -> ()){
        
        guard let profileImage = image else {return}
        
        let imageDatas = convertUIImagesToData(images: profileImage)
        
        APIService.call.uploadImagesToServer(route: .upload(imageDatas: imageDatas)) { (result:Result<UploadImageResponse,Error>) in
            switch result {
            case .success(let response):
                
                print("Response: \(response)")
                self.extractImageURLsToArray(response: response)
                complete(.success("true"))
                
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }
    func convertUIImagesToData(images:[UIImage]) -> [Data] {
        
        var imageDatas = [Data]()
        
        for image in images {
            if let data = image.jpegData(compressionQuality: 0.5) {
                imageDatas.append(data)
            }
        }
        return imageDatas
    }
    func extractImageURLsToArray(response:UploadImageResponse){
        imageUrls = [String]()
        let urls = response.urls
        
        for url in urls {
            imageUrls?.append(url)
        }
    }
    
    func updateProfile(complete: @escaping (Result<String,Error>)->()){

        guard let user = userProfile else { return }
        guard let full_name = user.full_name,
              let email = user.email,
              let pp_url = imageUrls?[0]
        else { return }
        
        let params:Parameters = ["full_name":full_name,"email":email,"pp_url":pp_url]

        APIService.call.objectRequestJSON(request: Router.editProfile(params: params )) { (result:Result<ResponseUpdateProfile,Error>) in
            switch result {
            case .success(let response):
                print(response.message)
                complete(.success("true"))
            case .failure(let err):
                complete(.failure(err))
            }
        }
    }
    
}

