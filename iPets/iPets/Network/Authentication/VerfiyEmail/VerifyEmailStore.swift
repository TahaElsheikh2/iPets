//
//  VerifyEmailStore.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
import Combine
class VerifyEmailStore{
    
    let networkManager: NetworkManager<AuthModelDTO> = NetworkManager()
    private var cancellableSet: Set<AnyCancellable> = []

    //TODO: Delete legacy
    func legacyVerifyEmail(verifyEmailDTO:VerifyEmailDTO, successCompletion: @escaping (AuthModelDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void){
        
        let request = VerifyEmailRequest.VerifyEmail(model: verifyEmailDTO)

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
    
    func verifyEmail(verifyEmailDTO:VerifyEmailDTO) -> AnyPublisher<AuthModelDTO?,IPETSErrors>{
        
        let request = VerifyEmailRequest.VerifyEmail(model: verifyEmailDTO)

        return networkManager.callApi(request: request)
    }
    
    func resendVerifyCode() -> AnyPublisher<AuthModelDTO?,IPETSErrors>{
        
        let request = VerifyEmailRequest.ResendVerifyCode
        return networkManager.callApi(request: request)
    }
}
