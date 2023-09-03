//
//  ResendVerifyCodeUseCase.swift
//  iPets
//
//  Created by Taha on 03/09/2023.
//

import Foundation
import Combine
protocol ResendVerifyCodeUseCaseProtocol {
    func resendVerifyCode() -> AnyPublisher<AuthModel,IPETSErrors>
}


class ResendVerifyCodeUseCase: ResendVerifyCodeUseCaseProtocol {
    
    private var repo : VerifyEmailRepoProtocol
    
    init(repo: VerifyEmailRepoProtocol = VerifyEmailRepo()) {
        self.repo = repo
    }

    func resendVerifyCode() -> AnyPublisher<AuthModel,IPETSErrors>{
        
        return self.repo.resendVerifyCode().tryMap{ model in
            if let model = model{
                return AuthModelMapper.getAuthModel(authModelDTO: model)
            }else{
                return AuthModel()
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

