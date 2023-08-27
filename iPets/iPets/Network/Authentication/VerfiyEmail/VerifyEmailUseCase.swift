//
//  VerifyEmailUseCase.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
protocol VerifyEmailUseCaseProtocol {
    func verifyEmail(verifyEmailDTO:VerifyEmailDTO, successCompletion:@escaping (AuthModel) -> Void, failureCompletion:@escaping (CustomError) -> Void)
}

class VerifyEmailUseCase: VerifyEmailUseCaseProtocol {
    
    private var repo : VerifyEmailRepoProtocol
    
    init(repo: VerifyEmailRepoProtocol = VerifyEmailRepo()) {
        self.repo = repo
    }
    
    func verifyEmail(verifyEmailDTO:VerifyEmailDTO, successCompletion:@escaping (AuthModel) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.repo.verifyEmail(verifyEmailDTO: verifyEmailDTO) { model in
          
            guard let authModel = model else{
                
                failureCompletion(CustomError(errorCode: 999,errorDesc: "authModel = nil"))
                return
            }
            successCompletion(authModel)
            
        } failureCompletion: { error in
            failureCompletion(error)
        }
    }
}
