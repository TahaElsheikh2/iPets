//
//  LoginUseCase.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
import Combine

protocol LoginUseCaseProtocol {
    func legacyLogin(loginModelDTO:LoginModelDTO, successCompletion:@escaping (AuthModelDTO) -> Void, failureCompletion:@escaping (CustomError) -> Void)
    func loginWith(loginModelDTO:LoginModelDTO) -> AnyPublisher<AuthModel,IPETSErrors>

}

class LoginUseCase: LoginUseCaseProtocol {
    
    private var repo : LoginRepoProtocol
    
    init(repo: LoginRepoProtocol = LoginRepo()) {
        self.repo = repo
    }
    
    //TODO: Delete legacyLogin
    func legacyLogin(loginModelDTO:LoginModelDTO, successCompletion:@escaping (AuthModelDTO) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.repo.legacyLoginAction(loginModelDTO: loginModelDTO) { model in
          
            guard let authModel = model else{
                
                failureCompletion(CustomError(errorCode: 999,errorDesc: "authModel = nil"))
                return
            }
            successCompletion(authModel)
            
        } failureCompletion: { error in
            failureCompletion(error)
        }
    }
    
    //TODO: Delete this func
//    func loginWith(loginModelDTO:LoginModelDTO) -> AnyPublisher<AuthModelDTO,NetworkErrors> {
//
//        return self.repo.loginWith(loginModelDTO: loginModelDTO).tryMap { optionalAuthModel -> AuthModelDTO in
//            if let authModel = optionalAuthModel {
//                return authModel
//            } else {
//                // Handle the case when the value is nil, possibly by throwing an error or providing a default value.
//                throw NetworkErrors.otherError("sd")  // Replace with appropriate error handling
//            }
//        }.mapError{error -> NetworkErrors in
//
//            if let error = error as? NetworkErrors{
//                return error
//            }else{
//                return NetworkErrors.otherError("model is Nill")
//            }
//        }.eraseToAnyPublisher()
//    }
    
    func loginWith(loginModelDTO:LoginModelDTO) -> AnyPublisher<AuthModel,IPETSErrors> {
        
        return self.repo.loginWith(loginModelDTO: loginModelDTO).tryMap { optionalAuthModel -> AuthModel in
            if let authModel = optionalAuthModel {
                return AuthModelMapper.getAuthModel(authModelDTO: authModel)
            } else {
                throw IPETSErrors.nilModel
            }
        }.mapError{error -> IPETSErrors in
            
            if let error = error as? IPETSErrors{
                return error
            }else{
                return IPETSErrors.mappingErrorToNetworkError
            }
        }.eraseToAnyPublisher()
    }
}
