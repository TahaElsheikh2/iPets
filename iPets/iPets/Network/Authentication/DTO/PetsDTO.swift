//
//  PetsDTO.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation

// MARK: - Pets
struct PetsDTO: Codable {
    var message: String?
    var data: [PetsModelData]?
    var status: Int?
}

// MARK: - Datum
struct PetsModelData: Codable {
    var id: Int?
    var petName, gender, proflie, petType: String?
    var birthDate: String?
    var latestEvent: LatestEvent?

    enum CodingKeys: String, CodingKey {
        case id
        case petName = "pet_name"
        case gender, proflie
        case petType = "pet_type"
        case birthDate = "birth_date"
        case latestEvent = "latest_event"
    }
}

// MARK: - LatestEvent
struct LatestEvent: Codable {
    var eventTime, eventTitle: String?

    enum CodingKeys: String, CodingKey {
        case eventTime = "event_time"
        case eventTitle = "event_title"
    }
}
