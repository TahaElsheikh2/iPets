//
//  LoginRepo.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
 import Combine
protocol LoginRepoProtocol{
    func legacyLoginAction(loginModelDTO:LoginModelDTO, successCompletion: @escaping (AuthModelDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void)
    func loginWith(loginModelDTO:LoginModelDTO) -> AnyPublisher<AuthModelDTO?,IPETSErrors>
}
class LoginRepo:LoginRepoProtocol{
    
    fileprivate var store = LoginStore()
// TODO: delete legace code
    func legacyLoginAction(loginModelDTO:LoginModelDTO, successCompletion: @escaping (AuthModelDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        store.legacyLoginAction(loginModelDTO: loginModelDTO, successCompletion: {[weak self] model in
            
            guard let self = self else { return }
            
            self.cacheData(loginModel: loginModelDTO, authModel: model)
            successCompletion(model);
        }, failureCompletion: { error in
            failureCompletion(error)
        })
    }
    
    func loginWith(loginModelDTO:LoginModelDTO) -> AnyPublisher<AuthModelDTO?,IPETSErrors> {

        return self.store.loginWith(loginModelDTO: loginModelDTO)
            .handleEvents(receiveOutput: {[weak self] model in
            self?.cacheData(loginModel: loginModelDTO, authModel: model)
        }).eraseToAnyPublisher()
    }

    private func cacheData(loginModel:LoginModelDTO, authModel:AuthModelDTO?){
        
        CacheHandler.saveStringToKeychain(value: loginModel.email, forKey: CacheConstants.Email_Constant)
        CacheHandler.saveStringToKeychain(value: loginModel.password, forKey: CacheConstants.Password_Constant)
        guard let token = authModel?.data?.token else {
            return
        }
        CacheHandler.saveStringToKeychain(value: token, forKey: CacheConstants.Token_Constant)
    }
}
