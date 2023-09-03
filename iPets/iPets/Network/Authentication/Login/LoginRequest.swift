//
//  LoginRequest.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//


import Foundation
import Alamofire

let LoginRequestEndPoint = "/api/auth/login"

struct LoginModelDTO{
    var email = ""
    var password = ""
}

enum LoginRequest {
    case Login(model:LoginModelDTO)
}

extension LoginRequest:ApiRequest{

    var baseURL: String{
        return "http://18.234.38.208:8000"
    }
    
    var path: String {
        return LoginRequestEndPoint
    }
    
    var method: HTTPMethod{
        return .post
    }
    
    var shouldAuth: Bool{
        return false
    }
    
    var parameters: [String : Any]? {
        switch self{
        case .Login(let model):
            return ["email":model.email,"password":model.password]
        }
    }
}
