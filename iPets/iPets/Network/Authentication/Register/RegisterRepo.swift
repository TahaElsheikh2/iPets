//
//  RegisterRepo.swift
//  iPets
//
//  Created by Taha on 26/08/2023.
//

import Foundation
import Combine
protocol RegisterRepoProtocol{
    func legacyRegisterAction(registerModel:RegisterModel, successCompletion: @escaping (AuthModelDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void)
    func registerAction(registerModel:RegisterModel) -> AnyPublisher<AuthModelDTO,IPETSErrors>
}
class RegisterRepo:RegisterRepoProtocol{
    
    fileprivate var store = RegisterStore()

    func legacyRegisterAction(registerModel:RegisterModel, successCompletion: @escaping (AuthModelDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        store.legacyRegisterAction(registerModel: registerModel, successCompletion: {[weak self] model in
            
            guard let self = self else { return }
            
            self.cacheData(registerModel: registerModel, authModel: model)
            successCompletion(model);
        }, failureCompletion: { error in
            failureCompletion(error)
        })
    }
    
    func registerAction(registerModel:RegisterModel) -> AnyPublisher<AuthModelDTO,IPETSErrors> {

        return Just(AuthModelDTO()).setFailureType(to: IPETSErrors.self).eraseToAnyPublisher()
        
        store.registerAction(registerModel: registerModel).tryMap{[weak self] model in
            
            guard let self = self else{ throw IPETSErrors.otherError("self = nil")}
            if let model = model{
                if self.tryCacheData(registerModel: registerModel, authModel: model){
                    return model
                }else{
                    throw IPETSErrors.otherError("failed to cache")
                }
            }else{
                throw IPETSErrors.nilModel
            }
        }
        .mapError { error -> IPETSErrors in
            if let error = error as? IPETSErrors{
                return error
            }else{
                return IPETSErrors.mappingErrorToNetworkError
            }
        }.eraseToAnyPublisher()
    }

}

//MARK: Cache data
extension RegisterRepo{
    
    private func cacheData(registerModel:RegisterModel, authModel:AuthModelDTO?){
        
        CacheHandler.saveStringToKeychain(value: registerModel.email, forKey: CacheConstants.Email_Constant)
        CacheHandler.saveStringToKeychain(value: registerModel.password, forKey: CacheConstants.Password_Constant)
        guard let token = authModel?.data?.token else {
            return
        }
        CacheHandler.saveStringToKeychain(value: token, forKey: CacheConstants.Token_Constant)
    }
    
    private func tryCacheData(registerModel:RegisterModel, authModel:AuthModelDTO) -> Bool{
        
        guard let token = authModel.data?.token else {
            return false
        }
        
        let emailFlag = CacheHandler.isSaveStringToKeychain(value: registerModel.email, forKey: CacheConstants.Email_Constant)
        let passwordFlag = CacheHandler.isSaveStringToKeychain(value: registerModel.password, forKey: CacheConstants.Password_Constant)
        let tokenFlag = CacheHandler.isSaveStringToKeychain(value: token, forKey: CacheConstants.Token_Constant)
        return (emailFlag && passwordFlag && tokenFlag)
    }
}
