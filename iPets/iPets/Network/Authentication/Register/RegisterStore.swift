//
//  RegisterStore.swift
//  iPets
//
//  Created by Taha on 26/08/2023.
//

import Foundation
import Combine

class RegisterStore{
    
    private let networkManager: NetworkManager<AuthModelDTO> = NetworkManager()
    private var cancellableSet: Set<AnyCancellable> = []
    
    //TODO: Delete Legacy code
    func legacyRegisterAction(registerModel:RegisterModel, successCompletion: @escaping (AuthModelDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void){
        
        let request = RegisterRequest.Register(model: registerModel)
        
        networkManager.callApi(request: request)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("### finished = \(result)")
                case .failure(let error):
                    print("### error = \(error)")
                    failureCompletion(CustomError())
                }
            }, receiveValue: {model in
                print("### receive Value = \(model)")
                successCompletion(model)
            }).store(in: &cancellableSet)
    }
    
    func registerAction(registerModel:RegisterModel) -> AnyPublisher<AuthModelDTO?,IPETSErrors>{
     
        let request = RegisterRequest.Register(model: registerModel)
        
        return networkManager.callApi(request: request)
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
