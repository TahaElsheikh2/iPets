//
//  GetAllPetsStore.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//


import Foundation
import Combine

class GetAllPetsStore{
    
    var networkManagerAllPets: NetworkManager<PetsDTO> = NetworkManager()
    var networkManagerAllPetsTypes: NetworkManager<PetsType> = NetworkManager()
    private var cancellableSet: Set<AnyCancellable> = []

//    func getAllPets(successCompletion: @escaping (PetsDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {
//
//        let request = GetAllPetsRequest.AllPets
//        networkManagerAllPets.requestWith(request: request) { model in
//            successCompletion(model)
//        } failureResponse: { error in
//            failureCompletion(ErrorHandler.getError(error:error))
//        }
//    }
    
    func getAllPets(successCompletion: @escaping (PetsDTO?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {
        
        let request = GetAllPetsRequest.AllPets

        networkManagerAllPets.callApi(request: request)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("### finished = \(result)")
                case .failure(let error):
                    print("### error = \(error)")
                    failureCompletion(CustomError())
                }
            }, receiveValue: {model in
                print("### receive Value = \(String(describing: model))")
                successCompletion(model)
            }).store(in: &cancellableSet)
    }
}

extension GetAllPetsStore{

//    func getAllPetsTypes(successCompletion: @escaping (PetsType?) -> Void, failureCompletion: @escaping (CustomError) -> Void) {
//
//        let request = GetAllPetsRequest.AllPetsTypes
//        networkManagerAllPetsTypes.requestWith(request: request) { model in
//            successCompletion(model)
//        } failureResponse: { error in
//            failureCompletion(ErrorHandler.getError(error:error))
//        }
//    }
    
    func getAllPetsTypes(successCompletion: @escaping (PetsType?) -> Void, failureCompletion: @escaping (CustomError) -> Void)  {
        
        let request = GetAllPetsRequest.AllPetsTypes

        networkManagerAllPetsTypes.callApi(request: request)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("### finished = \(result)")
                case .failure(let error):
                    print("### error = \(error)")
                    failureCompletion(CustomError())
                }
            }, receiveValue: {model in
                print("### receive Value = \(String(describing: model))")
                successCompletion(model)
            }).store(in: &cancellableSet)
    }
}
