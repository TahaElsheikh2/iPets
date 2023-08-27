//
//  GetAllPetsRequest.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//


import Foundation
import Alamofire

let GetAllPetsRequestEndPoint = "/api/pet"
let GetAllPetsTypesRequestEndPoint = "/api/pet/pet-types"

enum GetAllPetsRequest {
    
    case AllPets
    case AllPetsTypes
}

extension GetAllPetsRequest:ApiRequest{

    var path: String {
        switch self{
        case .AllPets:
            return GetAllPetsRequestEndPoint
        case .AllPetsTypes:
            return GetAllPetsTypesRequestEndPoint
        }
}
    
    var method: HTTPMethod{
        return .get
    }
}
