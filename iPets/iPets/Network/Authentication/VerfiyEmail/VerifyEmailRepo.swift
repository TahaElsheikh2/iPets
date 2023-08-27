//
//  VerifyEmailRepo.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
 
protocol VerifyEmailRepoProtocol{
    func verifyEmail(verifyEmailDTO:VerifyEmailDTO, successCompletion: @escaping (AuthModel?) -> Void, failureCompletion: @escaping (CustomError) -> Void)
}

class VerifyEmailRepo:VerifyEmailRepoProtocol{
    
    fileprivate var store = VerifyEmailStore()

    func verifyEmail(verifyEmailDTO:VerifyEmailDTO, successCompletion: @escaping (AuthModel?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        store.verifyEmail(verifyEmailDTO: verifyEmailDTO, successCompletion: { model in
            successCompletion(model);
        }, failureCompletion: { error in
            failureCompletion(error)
        })
    }
}
