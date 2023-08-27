//
//  RegisterUseCase.swift
//  iPets
//
//  Created by Taha on 26/08/2023.
//

import Foundation
protocol RegisterUseCaseProtocol {
    func registerWith(registerModel:RegisterModel, successCompletion:@escaping (AuthModel) -> Void, failureCompletion:@escaping (CustomError) -> Void)
}

class RegisterUseCase: RegisterUseCaseProtocol {
    
    private var repo : RegisterRepoProtocol
    
    init(repo: RegisterRepoProtocol = RegisterRepo()) {
        self.repo = repo
    }
    
    func registerWith(registerModel:RegisterModel, successCompletion:@escaping (AuthModel) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.repo.registerAction(registerModel: registerModel) { model in
          
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
