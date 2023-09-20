//
//  User.swift
//  ContinueAPI
//
//  Created by Kurumsal on 17.08.2023.
//

import Foundation

struct User {
    var fullName: String?
    var email: String
    var password: String
    var accessToken: String?
    var refreshToken: String?
}

// MARK: Profile Information Response Data Model

struct GetUserInfoResponse: Codable {
    var full_name: String
    var email: String
    var role: String
}


