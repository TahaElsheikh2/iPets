//
//  GetAllPetsUseCase.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation

protocol GetAllPetsUseCaseProtocol {
    func getAllPets(successCompletion:@escaping (PetsDTO) -> Void, failureCompletion:@escaping (CustomError) -> Void)
}

class GetAllPetsUseCase: GetAllPetsUseCaseProtocol {
    
    private var repo : GetAllPetsRepoProtocol
    
    init(repo: GetAllPetsRepoProtocol = GetAllPetsRepo()) {
        self.repo = repo
    }
    
    func getAllPets(successCompletion:@escaping (PetsDTO) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.repo.getAllPets() { model in
          
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
