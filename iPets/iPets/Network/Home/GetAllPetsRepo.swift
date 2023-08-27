//
//  GetAllPetsRepo.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//


import Foundation
 
protocol GetAllPetsRepoProtocol{
    func getAllPets(successCompletion: @escaping (PetsDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void)
    func getAllPetsTypes(successCompletion: @escaping (PetsType?) -> Void, failureCompletion: @escaping (CustomError) -> Void)
}

class GetAllPetsRepo:GetAllPetsRepoProtocol{
    
    fileprivate var store = GetAllPetsStore()

    func getAllPets(successCompletion: @escaping (PetsDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        store.getAllPets(successCompletion: { model in
            successCompletion(model);
        }, failureCompletion: { error in
            failureCompletion(error)
        })
    }
}

extension GetAllPetsRepo{
    
    func getAllPetsTypes(successCompletion: @escaping (PetsType?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        store.getAllPetsTypes(successCompletion: { model in
            successCompletion(model);
        }, failureCompletion: { error in
            failureCompletion(error)
        })
    }
}
