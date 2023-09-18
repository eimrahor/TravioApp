//
//  RegisterResponseModel.swift
//  TravioApp
//
//  Created by imrahor on 18.09.2023.
//

import Foundation

// MARK: Register Response Data Model

struct UserRegisterResponse: Codable {
    let message: String
    let status: String
}
