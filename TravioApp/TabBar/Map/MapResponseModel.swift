//
//  MapResponse.swift
//  TravioApp
//
//  Created by imrahor on 18.09.2023.
//

import Foundation

// MARK: Get All Places Response Data Model

struct GetAllPlaces: Codable {
    var data: ArrData
    var status: String
}

struct ArrData: Codable {
    var count: Int
    var places: [Place]
}
