//
//  TokenManager.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
import JWTDecode
protocol TokenManagerProtocol{
    
    func getCachedToken() -> String
    func isValidToken() -> Bool
    func getNewToken(successCompletion:@escaping (AuthModel) -> Void, failureCompletion:@escaping (CustomError) -> Void)
}

class TokenManager: TokenManagerProtocol {
   
    private var authUseCase: LoginUseCaseProtocol
    
    init(authUseCase:LoginUseCaseProtocol = LoginUseCase()) {
        self.authUseCase = authUseCase
    }
    
    func isValidToken() -> Bool {

        var decodedToken :JWT?
        
        do{
             decodedToken = try decode(jwt: self.getCachedToken())
        }catch{
            print("error TokenManager->isValidToken token decoded failed")
        }
        return decodedToken?.expired ?? false
    }
    
    func getNewToken(successCompletion:@escaping (AuthModel) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.authUseCase.login(loginModelDTO: getLoginCredential()) { model in
            successCompletion(model)
        } failureCompletion: { error in
            failureCompletion(error)
        }
    }
    
    private func getLoginCredential() -> LoginModelDTO{
        
        var loginModel = LoginModelDTO()
        loginModel.email = CacheHandler.getStringFromKeychain(forKey: CacheConstants.Email_Constant) ?? ""
        loginModel.email = CacheHandler.getStringFromKeychain(forKey: CacheConstants.Password_Constant) ?? ""
        
        return loginModel
    }
    
    func getCachedToken() -> String {
        let token = CacheHandler.getStringFromKeychain(forKey: CacheConstants.Token_Constant) ?? ""
        return token
    }
}

struct CacheConstants {
    static let Token_Constant = "token"
    static let Email_Constant = "email"
    static let Password_Constant = "passord"
}
