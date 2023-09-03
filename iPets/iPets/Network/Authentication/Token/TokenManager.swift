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
}

class TokenManager: TokenManagerProtocol {

    func isValidToken() -> Bool {

        var decodedToken :JWT?
        
        do{
             decodedToken = try decode(jwt: self.getCachedToken())
        }catch{
            print("error TokenManager->isValidToken token decoded failed")
        }
        return !(decodedToken?.expired ?? true)
    }
    
    func getCachedToken() -> String {
        let token = CacheHandler.getStringFromKeychain(forKey: CacheConstants.Token_Constant) ?? ""
        return token
    }
}

struct CacheConstants {
    static let Token_Constant = "token"
    static let Email_Constant = "email"
    static let Password_Constant = "password"
}
