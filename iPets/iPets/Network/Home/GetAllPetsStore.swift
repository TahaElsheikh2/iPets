//
//  GetAllPetsStore.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//


import Foundation

class GetAllPetsStore{
    
    var networkManagerAllPets: NetworkManager<PetsDTO> = NetworkManager()
    var networkManagerAllPetsTypes: NetworkManager<PetsType> = NetworkManager()

    func getAllPets(successCompletion: @escaping (PetsDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        let request = GetAllPetsRequest.AllPets
        networkManagerAllPets.requestWith(request: request) { model in
            successCompletion(model)
        } failureResponse: { error in
            failureCompletion(ErrorHandler.getError(error:error))
        }
    }
}

extension GetAllPetsStore{

    func getAllPetsTypes(successCompletion: @escaping (PetsType?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {

        let request = GetAllPetsRequest.AllPetsTypes
        networkManagerAllPetsTypes.requestWith(request: request) { model in
            successCompletion(model)
        } failureResponse: { error in
            failureCompletion(ErrorHandler.getError(error:error))
        }
    }
}
