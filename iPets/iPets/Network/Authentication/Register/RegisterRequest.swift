//
//  RegisterRequest.swift
//  iPets
//
//  Created by Taha on 26/08/2023.
//

import Foundation
import Alamofire

let RegisterEndPoint = "/api/auth/login"

enum RegisterRequest {
    case Register
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
    
    var parameters: [String : Any]? {

        let parameters = ["email":"halaabdulmottleb@gmail.com","password":"12345678", "longitude":"30.1", "latitude":"22.8"]
        return parameters
    }
    
//    func body() throws -> Data? {
//
//        let bodyData = ["email":"halaabdulmottleb@gmail.com","password":"12345678", "longitude":"30.1", "latitude":"22.8"]
//        let data = try?JSONSerialization.data(withJSONObject:  bodyData, options: [])
//        return data
//    }
}
