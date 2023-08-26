//
//  RegisterRepo.swift
//  iPets
//
//  Created by Taha on 26/08/2023.
//

import Foundation

class RegisterRepo{
    
    var store = RegisterStore()

    func registerAction(successCompletion: @escaping (AuthModel?) -> Void, failureCompletion: @escaping (String) -> Void) {
        let request = RegisterRequest.Register
        
        store.requestWith(request: request) { (apiResponse) in
//            if apiResponse.success {
//                successCompletion(apiResponse.data)
                print("fetchStoriesByUsername Success = \(apiResponse.data)")
//            } else {
                failureCompletion(apiResponse.message ?? "error")
                print("fetchStoriesByUsername Failer = \(apiResponse.message)")
//            }
        }
    }

}
