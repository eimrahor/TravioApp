//
//  DetailVisitsModel.swift
//  TravioApp
//
//  Created by imrahor on 5.09.2023.
//

import Foundation

// MARK: Check Visit By Place ID response model
struct DetailVisitsModel: Codable {
    var message: Bool
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
