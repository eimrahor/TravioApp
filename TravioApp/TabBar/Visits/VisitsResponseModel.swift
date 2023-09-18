//
//  UserVisitsResponse.swift
//  TravioApp
//
//  Created by imrahor on 18.09.2023.
//

import Foundation

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
