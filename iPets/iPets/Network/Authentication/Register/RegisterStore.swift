//
//  RegisterStore.swift
//  iPets
//
//  Created by Taha on 26/08/2023.
//

import Foundation

class RegisterStore{
    
    let networkManager: NetworkManager<AuthModel> = NetworkManager()
    
    func registerAction(registerModel:RegisterModel, successCompletion: @escaping (AuthModel?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        let request = RegisterRequest.Register(model: registerModel)
        
        networkManager.requestWith(request: request) { model in
            successCompletion(model)
        } failureResponse: { error in
            
            failureCompletion(ErrorHandler.getError(error:error))
        }
    }
}

struct ErrorHandler {
    
    static func getError(error: CustomError) -> CustomError {
        var customError = error
        
        switch customError.errorCode{
        case 0:
            customError.errorDesc = "Success"
        case 422:
            customError.errorDesc = "The email has already been taken"
        default:
            customError.errorDesc = "something went wrong"
        }
        return customError
    }
}
