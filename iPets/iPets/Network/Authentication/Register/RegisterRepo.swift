//
//  RegisterRepo.swift
//  iPets
//
//  Created by Taha on 26/08/2023.
//

import Foundation
 
protocol RegisterRepoProtocol{
    func registerAction(registerModel:RegisterModel, successCompletion: @escaping (AuthModel?) -> Void, failureCompletion: @escaping (CustomError) -> Void)
}
class RegisterRepo:RegisterRepoProtocol{
    
    fileprivate var store = RegisterStore()

    func registerAction(registerModel:RegisterModel, successCompletion: @escaping (AuthModel?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        store.registerAction(registerModel: registerModel, successCompletion: {[weak self] model in
            
            guard let self = self else { return }
            
            self.cacheData(registerModel: registerModel, authModel: model)
            successCompletion(model);
        }, failureCompletion: { error in
            failureCompletion(error)
        })
    }
    
    private func cacheData(registerModel:RegisterModel, authModel:AuthModel?){
        
        CacheHandler.saveStringToKeychain(value: registerModel.email, forKey: CacheConstants.Email_Constant)
        CacheHandler.saveStringToKeychain(value: registerModel.password, forKey: CacheConstants.Password_Constant)
        guard let token = authModel?.data?.token else {
            return
        }
        CacheHandler.saveStringToKeychain(value: token, forKey: CacheConstants.Token_Constant)
    }
}
