//
//  VerifyEmailRequest.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
import Alamofire

let VerifyEmailEndPoint = "/api/auth/verify-email/"
let ResendVerifyCodeEndPoint = "/api/auth/resend-verify-email"

struct VerifyEmailDTO{
    var code = ""
}
enum VerifyEmailRequest {
    
    case VerifyEmail(model:VerifyEmailDTO)
    case ResendVerifyCode
}

extension VerifyEmailRequest:ApiRequest{

    var path: String {

        switch self
        {
        case .VerifyEmail(let model):
            return VerifyEmailEndPoint + model.code
        case .ResendVerifyCode:
            return ResendVerifyCodeEndPoint
        }
    }
    
    var method: HTTPMethod{
        return .get
    }
}
