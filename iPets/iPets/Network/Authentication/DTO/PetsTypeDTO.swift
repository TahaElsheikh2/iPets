//
//  PetsTypeDTO.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation

// MARK: - PetsType
struct PetsType: Codable {
    var data: [PetsTypeModelData]?
    var messageCode, message: String?
    var statusCode: Int?

    enum CodingKeys: String, CodingKey {
        case data
        case messageCode = "message_code"
        case message
        case statusCode = "status_code"
    }
}

// MARK: - Datum
struct PetsTypeModelData: Codable {
    var id: Int?
    var type: String?
}
