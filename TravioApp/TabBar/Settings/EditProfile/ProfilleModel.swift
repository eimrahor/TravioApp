//
//  ProfilleModel.swift
//  TravioApp
//
//  Created by Elif Poyraz on 10.09.2023.
//

import Foundation

struct UserProfile:Codable{
    var id: String?
    var full_name: String?
    var email: String?
    var pp_url: String?
    var role: String?
    var created_at: String?
    var updated_at: String?
}

struct ResponseUpdateProfile:Codable{
    var message: String
    var status: String
}
