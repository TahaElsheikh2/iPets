//
//  VerifyEmailUseCase.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
import Combine
protocol VerifyEmailUseCaseProtocol {
    func legacyVerifyEmail(verifyEmailDTO:VerifyEmailDTO, successCompletion:@escaping (AuthModelDTO) -> Void, failureCompletion:@escaping (CustomError) -> Void)
    func verifyEmail(verifyEmailDTO:VerifyEmailDTO) -> AnyPublisher<AuthModel,IPETSErrors>
}

class VerifyEmailUseCase: VerifyEmailUseCaseProtocol {
    
    private var repo : VerifyEmailRepoProtocol
    
    init(repo: VerifyEmailRepoProtocol = VerifyEmailRepo()) {
        self.repo = repo
    }
    
    //TODO: Delete legacy
    func legacyVerifyEmail(verifyEmailDTO:VerifyEmailDTO, successCompletion:@escaping (AuthModelDTO) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.repo.legacyVerifyEmail(verifyEmailDTO: verifyEmailDTO) { model in
          
            guard let authModel = model else{
                
                failureCompletion(CustomError(errorCode: 999,errorDesc: "authModel = nil"))
                return
            }
            successCompletion(authModel)
            
        } failureCompletion: { error in
            failureCompletion(error)
        }
    }
    
    func verifyEmail(verifyEmailDTO:VerifyEmailDTO) -> AnyPublisher<AuthModel,IPETSErrors>{
        
        return self.repo.verifyEmail(verifyEmailDTO: verifyEmailDTO).tryMap{ model in
            if let model = model{
                return AuthModelMapper.getAuthModel(authModelDTO: model)
            }else{
                throw IPETSErrors.nilModel
            }
        }
        .mapError{error -> IPETSErrors in
            
            if let error = error as? IPETSErrors{
                return error
            }else{
                return IPETSErrors.mappingErrorToNetworkError
            }
        }.eraseToAnyPublisher()
    }
}

