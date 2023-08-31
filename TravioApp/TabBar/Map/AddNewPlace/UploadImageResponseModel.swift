//
//  uploadImageResponseModal.swift
//  TravioApp
//
//  Created by Elif Poyraz on 30.08.2023.
//

import Foundation

struct UploadImageResponse:Codable
{
    var messageType: String
    var message: String
    var urls: [String]
}
