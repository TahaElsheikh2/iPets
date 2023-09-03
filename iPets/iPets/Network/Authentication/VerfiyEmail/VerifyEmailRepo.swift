//
//  VerifyEmailRepo.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
 import Combine
protocol VerifyEmailRepoProtocol{
    func legacyVerifyEmail(verifyEmailDTO:VerifyEmailDTO, successCompletion: @escaping (AuthModelDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void)
    func verifyEmail(verifyEmailDTO:VerifyEmailDTO) -> AnyPublisher<AuthModelDTO?,IPETSErrors>
    func resendVerifyCode() -> AnyPublisher<AuthModelDTO?,IPETSErrors>
}

class VerifyEmailRepo:VerifyEmailRepoProtocol{
    
    fileprivate var store = VerifyEmailStore()
    
    //TODO: Delete Legacy
    func legacyVerifyEmail(verifyEmailDTO:VerifyEmailDTO, successCompletion: @escaping (AuthModelDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {
        
        store.legacyVerifyEmail(verifyEmailDTO: verifyEmailDTO, successCompletion: { model in
            successCompletion(model);
        }, failureCompletion: { error in
            failureCompletion(error)
        })
    }
    
    func verifyEmail(verifyEmailDTO:VerifyEmailDTO) -> AnyPublisher<AuthModelDTO?,IPETSErrors> {
        
        store.verifyEmail(verifyEmailDTO: verifyEmailDTO).tryMap{[weak self] model in
            
            guard let self = self else{
                throw IPETSErrors.otherError("self = nil")
            }
            
            if self.tryCacheData(authModel: model){
                return model
            }else{
                throw IPETSErrors.otherError("cache handler failed to cache the token")
            }
        }
        .mapError({ error -> IPETSErrors in
            
            if let error = error as? IPETSErrors{
                return error
            }else{
                
                return IPETSErrors.mappingErrorToNetworkError
            }
        })
        .eraseToAnyPublisher()
    }
    
    func resendVerifyCode() -> AnyPublisher<AuthModelDTO?,IPETSErrors>{
        
        return self.store.resendVerifyCode()
    }
}

//MARK: Cache
extension VerifyEmailRepo{
    
    private func cacheData(authModel:AuthModelDTO?){
        
        guard let token = authModel?.data?.token else {
            return
        }
        CacheHandler.saveStringToKeychain(value: token, forKey: CacheConstants.Token_Constant)
    }
    
    private func tryCacheData(authModel:AuthModelDTO?) -> Bool{
        
        if let model = authModel, let data = model.data, let token = data.token{
            
            if CacheHandler.isSaveStringToKeychain(value: token, forKey: CacheConstants.Token_Constant){
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
}
