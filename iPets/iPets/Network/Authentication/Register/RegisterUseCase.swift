//
//  RegisterUseCase.swift
//  iPets
//
//  Created by Taha on 26/08/2023.
//

import Foundation
import Combine

protocol RegisterUseCaseProtocol {
    func legacyRegisterWith(registerModel:RegisterModel, successCompletion:@escaping (AuthModelDTO) -> Void, failureCompletion:@escaping (CustomError) -> Void)
    func registerWith(registerModel:RegisterModel) -> AnyPublisher<AuthModel,IPETSErrors>
}

class RegisterUseCase: RegisterUseCaseProtocol {
    
    private var repo : RegisterRepoProtocol
    
    init(repo: RegisterRepoProtocol = RegisterRepo()) {
        self.repo = repo
    }
    
    //TODO: Delete Legacy code
    func legacyRegisterWith(registerModel:RegisterModel, successCompletion:@escaping (AuthModelDTO) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.repo.legacyRegisterAction(registerModel: registerModel) { model in
          
            guard let authModel = model else{
                
                failureCompletion(CustomError(errorCode: 999,errorDesc: "authModel = nil"))
                return
            }
            successCompletion(authModel)
            
        } failureCompletion: { error in
            failureCompletion(error)
        }
    }
    
    func registerWith(registerModel:RegisterModel) -> AnyPublisher<AuthModel,IPETSErrors> {
        
        return self.repo.registerAction(registerModel: registerModel).map{ model -> AuthModel in
            
            AuthModelMapper.getAuthModel(authModelDTO: model)
        }.eraseToAnyPublisher()
    }
}
