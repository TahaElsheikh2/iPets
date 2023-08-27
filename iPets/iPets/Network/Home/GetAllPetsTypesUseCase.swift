//
//  GetAllPetsTypesUseCase.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation

protocol GetAllPetsTypesUseCaseProtocol {
    func getAllPetsTypes(successCompletion:@escaping (PetsType) -> Void, failureCompletion:@escaping (CustomError) -> Void)
}

class GetAllPetsTypesUseCase: GetAllPetsTypesUseCaseProtocol {
    
    private var repo : GetAllPetsRepoProtocol
    
    init(repo: GetAllPetsRepoProtocol = GetAllPetsRepo()) {
        self.repo = repo
    }
    
    func getAllPetsTypes(successCompletion:@escaping (PetsType) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.repo.getAllPetsTypes() { model in
          
            guard let authModel = model else{
                
                failureCompletion(CustomError(errorCode: 999,errorDesc: "PetsModel = nil"))
                return
            }
            successCompletion(authModel)
            
        } failureCompletion: { error in
            failureCompletion(error)
        }
    }
}
