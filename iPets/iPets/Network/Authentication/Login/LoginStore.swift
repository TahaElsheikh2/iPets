//
//  LoginStore.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation

class LoginStore{
    
    let networkManager: NetworkManager<AuthModel> = NetworkManager()
    
    func loginAction(loginModelDTO:LoginModelDTO, successCompletion: @escaping (AuthModel?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        let request = LoginRequest.Login(model: loginModelDTO)
        
        networkManager.requestWith(request: request) { model in
            successCompletion(model)
        } failureResponse: { error in
            
            failureCompletion(ErrorHandler.getError(error:error))
        }
    }
}
