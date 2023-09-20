//
//  LoginResponseModel.swift
//  TravioApp
//
//  Created by imrahor on 18.09.2023.
//

import Foundation

// MARK: Login Response Data Model

struct UserLoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
