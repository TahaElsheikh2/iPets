//
//  VerifyEmailRequest.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
import Alamofire

let VerifyEmailEndPoint = "/api/auth/verify-email/"

struct VerifyEmailDTO{
    var code = ""
}
enum VerifyEmailRequest {
    
    case VerifyEmail(model:VerifyEmailDTO)
}

extension VerifyEmailRequest:ApiRequest{

    var path: String {

        switch self
        {
        case .VerifyEmail(let model):
            return RegisterEndPoint + model.code
        }
    }
    
    var method: HTTPMethod{
        return .get
    }
}
