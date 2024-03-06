//
//  UserDetails.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 06/03/2024.
//

import Foundation

struct UserDetails: Codable{
    var username: String
    var password: String
    var email: String
    var balance: Double
    var id: Int64
}
