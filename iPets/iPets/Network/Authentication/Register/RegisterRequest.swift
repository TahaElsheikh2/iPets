//
//  RegisterRequest.swift
//  iPets
//
//  Created by Taha on 26/08/2023.
//

import Foundation
import Alamofire

let RegisterEndPoint = "/api/auth/register"
struct RegisterModel{
    var name = ""
    var password = ""
    var email = ""
    var phone = ""

}
enum RegisterRequest {
    case Register(model:RegisterModel)
}

extension RegisterRequest:ApiRequest{

    var baseURL: String{
        return "http://18.234.38.208:8000"
    }
    
    var path: String {
        return RegisterEndPoint
    }
    
    var method: HTTPMethod{
        return .post
    }
    
    var shouldAuth: Bool{
        return false
    }
    
    var parameters: [String : Any]? {
        switch self{
        case .Register(let model):
            return ["email":model.email,"password":model.password, "user_name":model.name, "phone_1":model.phone]
        }
    }
}
