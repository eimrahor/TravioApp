//
//  DetailVisitsModel.swift
//  TravioApp
//
//  Created by imrahor on 5.09.2023.
//

import Foundation

// MARK: Get All Gallery by Place ID Response Data Model

struct GetGalleryImages: Codable {
    var data: DataClassForImages
    var status: String
}

struct DataClassForImages: Codable {
    var images: [Image]
    var count: Int
}

struct Image: Codable {
    var id: String
    var place_id : String
    var image_url: String
    var created_at: String
    var updated_at: String
}

// MARK: Get A Visit By ID Response Data Model

struct GetVisit: Codable {
    var data: GetData
    var status: String
}

struct GetData: Codable {
    var visit: Visit
}

// MARK: Get a Place by ID response Data Model

struct GetAPlaces: Codable {
    var data: DataPlace
    var status: String
}

struct DataPlace: Codable {
    let place: Place
}

// MARK: Check Visit By Place ID response model

struct DetailVisitsModel: Codable {
    var message: String
    var status: String
}

// MARK: Delete A Visit By PlaceID response model

struct DeleteAVisit: Codable  {
    var message: String
    var status: String
}

// MARK: Post A Visit response model

struct PostAVisit: Codable {
    var message: String
    var status: String
}
