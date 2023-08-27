//
//  VerifyEmailStore.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation

class VerifyEmailStore{
    
    let networkManager: NetworkManager<AuthModel> = NetworkManager()
    
    func verifyEmail(verifyEmailDTO:VerifyEmailDTO, successCompletion: @escaping (AuthModel?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        let request = VerifyEmailRequest.VerifyEmail(model: verifyEmailDTO)
        networkManager.requestWith(request: request) { model in
            successCompletion(model)
        } failureResponse: { error in
            
            failureCompletion(ErrorHandler.getError(error:error))
        }
    }
}
