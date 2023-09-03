//
//  AuthUseCase.swift
//  iPets
//
//  Created by Taha on 02/09/2023.
//

import Foundation
import Combine
protocol AuthUseCaseProtocol {
    func reAuth() -> AnyPublisher<AuthModelDTO?,IPETSErrors>
}

class AuthUseCase: AuthUseCaseProtocol {
    
    private var repo : LoginRepoProtocol
    
    init(repo: LoginRepoProtocol = LoginRepo()) {
        self.repo = repo
    }

    func reAuth() -> AnyPublisher<AuthModelDTO?,IPETSErrors> {

        let email = CacheHandler.getStringFromKeychain(forKey: CacheConstants.Email_Constant) ?? ""
        let password = CacheHandler.getStringFromKeychain(forKey: CacheConstants.Password_Constant) ?? ""
        let loginModelDTO = LoginModelDTO(email: email,password: password)
        
        return repo.loginWith(loginModelDTO: loginModelDTO)
        
    }
}
