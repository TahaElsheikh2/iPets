//
//  LoginStore.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
import Combine

class LoginStore{
    
    let networkManager: NetworkManager<AuthModelDTO> = NetworkManager()
    private var cancellableSet: Set<AnyCancellable> = []

    //TODO: remove legacy login
    func legacyLoginAction(loginModelDTO:LoginModelDTO, successCompletion: @escaping (AuthModelDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {
        
        let request = LoginRequest.Login(model: loginModelDTO)
        
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

    func loginWith(loginModelDTO:LoginModelDTO) -> AnyPublisher<AuthModelDTO?,IPETSErrors> {
        
        let request = LoginRequest.Login(model: loginModelDTO)
        
        return networkManager.callApi(request: request)
    }
}
