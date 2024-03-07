//
//  UpdateProfile.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 07/03/2024.
//

import Foundation

struct UpdateProfileRequest: Codable{
    var username: String
    var image: String
    var password: String
}
