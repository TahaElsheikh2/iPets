//
//  LoginRepo.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
 
protocol LoginRepoProtocol{
    func loginAction(loginModelDTO:LoginModelDTO, successCompletion: @escaping (AuthModel?) -> Void, failureCompletion: @escaping (CustomError) -> Void)
}
class LoginRepo:LoginRepoProtocol{
    
    fileprivate var store = LoginStore()

    func loginAction(loginModelDTO:LoginModelDTO, successCompletion: @escaping (AuthModel?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        store.loginAction(loginModelDTO: loginModelDTO, successCompletion: {[weak self] model in
            
            guard let self = self else { return }
            
            self.cacheData(loginModel: loginModelDTO, authModel: model)
            successCompletion(model);
        }, failureCompletion: { error in
            failureCompletion(error)
        })
    }
    
    private func cacheData(loginModel:LoginModelDTO, authModel:AuthModel?){
        
        CacheHandler.saveStringToKeychain(value: loginModel.email, forKey: CacheConstants.Email_Constant)
        CacheHandler.saveStringToKeychain(value: loginModel.password, forKey: CacheConstants.Password_Constant)
        guard let token = authModel?.data?.token else {
            return
        }
        CacheHandler.saveStringToKeychain(value: token, forKey: CacheConstants.Token_Constant)
    }
}
