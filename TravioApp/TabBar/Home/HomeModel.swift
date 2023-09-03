//
//  HomeModel.swift
//  TravioApp
//
//  Created by imrahor on 3.09.2023.
//

import Foundation

// MARK: Get Popular Places response model
struct PopularPlaces: Codable {
    let data: PPlaces
    let status: String
}

struct PPlaces: Codable {
    let count: Int
    let places: [Place]
}

