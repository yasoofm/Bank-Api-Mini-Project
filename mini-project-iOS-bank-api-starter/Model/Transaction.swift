//
//  Transaction.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 07/03/2024.
//

import Foundation

struct Transaction: Codable {
    let senderId: Int64
    let receiverId: Int64
    let amount: Double
    let type: String
}
