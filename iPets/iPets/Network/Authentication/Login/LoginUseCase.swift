//
//  LoginUseCase.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
protocol LoginUseCaseProtocol {
    func login(loginModelDTO:LoginModelDTO, successCompletion:@escaping (AuthModel) -> Void, failureCompletion:@escaping (CustomError) -> Void)
}

class LoginUseCase: LoginUseCaseProtocol {
    
    private var repo : LoginRepoProtocol
    
    init(repo: LoginRepoProtocol = LoginRepo()) {
        self.repo = repo
    }
    
    func login(loginModelDTO:LoginModelDTO, successCompletion:@escaping (AuthModel) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.repo.loginAction(loginModelDTO: loginModelDTO) { model in
          
            guard let authModel = model else{
                
                failureCompletion(CustomError(errorCode: 999,errorDesc: "authModel = nil"))
                return
            }
            successCompletion(authModel)
            
        } failureCompletion: { error in
            failureCompletion(error)
        }
    }
}
