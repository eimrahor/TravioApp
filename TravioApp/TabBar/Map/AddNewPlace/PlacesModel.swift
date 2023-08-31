//
//  PlacesModal.swift
//  TravioApp
//
//  Created by Elif Poyraz on 31.08.2023.
//

import Foundation

// MARK: Post request
struct PlaceToMap:Codable{
    
  var  place: String?
  var  title: String?
  var  description: String?
  var  cover_image_url: String?
  var  latitude: Double?
  var  longitude: Double?
    
}

// MARK: Post response
struct PostPlacesResponse:Codable{
    
    var message: String
    var status: String
    
}
