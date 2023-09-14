//
//  User.swift
//  ContinueAPI
//
//  Created by Kurumsal on 17.08.2023.
//

import Foundation

struct User {
    var full_name: String
    var email: String
    var password: String
    var accessToken: String?
    var refreshToken: String?
}

// MARK: Register Response Data Model

struct UserRegisterResponse: Codable {
    let message: String
    let status: String
}

// MARK: Login Response Data Model

struct UserLoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
}

// MARK: Profile Information Response Data Model

struct GetUserInfoResponse: Codable {
    var full_name: String
    var email: String
    var role: String
}

// MARK: Get All Visits Response Data Model

struct ListUserVisitsResponse: Codable {
   var data: DataClass
   var status: String
}

struct DataClass: Codable {
    var count: Int
    var visits: [Visit]
}

struct Visit: Codable {
    let id, place_id, visited_at, created_at: String
    let updated_at: String
    let place: Place
}

struct Place: Codable {
    var id, creator, place, title, description: String
    var cover_image_url: String
    var latitude, longitude: Double
    var created_at, updated_at: String
}

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

// MARK: Get All Places Response Data Model

struct GetAllPlaces: Codable {
    var data: ArrData
    var status: String
}

struct ArrData: Codable {
    var count: Int
    var places: [Place]
}


// MARK: Get a Place by ID response Data Model

struct GetAPlaces: Codable {
    var data: DataPlace
    var status: String
}

struct DataPlace: Codable {
    let place: Place
}
