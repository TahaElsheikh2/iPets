//
//  AuthModelMapper.swift
//  iPets
//
//  Created by Taha on 03/09/2023.
//

import Foundation

struct AuthModelMapper {
    
    static func getAuthModel(authModelDTO:AuthModelDTO) -> AuthModel{
        return AuthModel(authModelDTO: authModelDTO)
    }
}

// MARK: - AuthModel
struct AuthModel {
   
    var id = Int(0)
    var userName = ""
    var email = ""
    var type = ""
    var profileImage = ""
    var token = ""
    var longitude = ""
    var latitude = ""
    var is_verified = false
    
    init() {}
    init(authModelDTO:AuthModelDTO) {
        
        self.userName = authModelDTO.data?.userName ?? ""
        self.email = authModelDTO.data?.email ?? ""
        self.type = authModelDTO.data?.type ?? ""
        self.profileImage = authModelDTO.data?.profileImage ?? ""
        self.latitude = authModelDTO.data?.latitude ?? ""
        self.longitude = authModelDTO.data?.longitude ?? ""
        self.id = authModelDTO.data?.id ?? 0
        self.is_verified = authModelDTO.data?.is_verified ?? false
    }
    

}
