//
//  StoryRequestBuilder.swift
//  iPets
//
//  Created by Taha on 23/08/2023.
//

import Foundation
import CoreData
import Alamofire

enum StoryRequestBuilder: ApiRequest{
    
    case first
}
extension StoryRequestBuilder{

    var apiPath: String {
        return "v3/02d7fad4-df90-4d37-b218-9a3c4cbca822"
    }


    var method: HTTPMethod {
        return .get
    }

}

protocol Mappable {
    var objectID: NSManagedObjectID? { get set }
    init()
}

class DomainBaseEntity: Mappable {
    var objectID: NSManagedObjectID?

    required init() {
    }
}


class Story: DomainBaseEntity, Codable {
    var storyNumber: Int?
    var clapsCount: Int?
    var title: String?
    var published: Bool?
}
