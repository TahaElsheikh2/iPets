//
//  AuthModelDTO.swift
//  iPets
//
//  Created by Taha on 26/08/2023.
//

import Foundation

// MARK: - AuthModelDTO
struct AuthModelDTO: Codable {
    var data: AuthModelData?
    var messageCode, message: String?
    var statusCode: Int?

    enum CodingKeys: String, CodingKey {
        case data
        case messageCode = "message_code"
        case message
        case statusCode = "status_code"
    }
}

// MARK: - DataClass
struct AuthModelData: Codable {
    var id: Int?
    var userName, email, type: String?
    var profileImage: String?
    var token: String?
    var longitude, latitude: String?
    var is_verified: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "user_name"
        case email, type
        case profileImage = "profile_image"
        case token, longitude, latitude
        case is_verified
    }
}
