//
//  RegisterViewModel.swift
//  iPets
//
//  Created by Taha on 03/09/2023.
//

import Foundation
import Combine

struct RegisterPresentationModel {
    var userName : String?
    var mail : String?
    var phone : String?
    var password : String?
    var confirmPassword : String?
}

class RegisterViewModel {
   
    let registerUseCase: RegisterUseCaseProtocol = RegisterUseCase()

    let resultSubject = PassthroughSubject<AuthModel,IPETSErrors>()
    var cancelable = Set<AnyCancellable>()
    
    //TODO: Delete legacy
//    func legacyRegisterAction(model:RegisterPresentationModel, success:() -> Void, failure: () -> Void) {
//
//        let registerModel = getModel(registerPresentationModel: model)
//
//        registerUseCase.legacyRegisterWith(registerModel: registerModel, successCompletion: { model in
//            print("#### model.userName = \(model.data?.userName)")
//            print("#### model type= \(model.data?.type)")
//            print("#### model token= \(model.data?.token)")
//            print("#### model email= \(model.data?.email)")
//            print("#### model id= \(model.data?.id)")
//
//        }, failureCompletion: { error in
//            print("#### error.desc = \(error.errorDesc)")
//            print("#### error.errorCode = \(error.errorCode)")
//
//        })
//    }
    
    func registerAction(model:RegisterPresentationModel) -> AnyPublisher<AuthModel,IPETSErrors> {
        
        let registerModel = getModel(registerPresentationModel: model)

        return self.registerUseCase.registerWith(registerModel: registerModel)
//            .receive(on: DispatchQueue.main)
//            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
//            .sink {[weak self] complete in
//            switch complete{
//            case .finished:
//
//                print("finished")
//            case .failure(let error):
//                self?.handleFailure(error: error)
//                print("error = \(error.localizedDescription)")
//            }
//        } receiveValue: {[weak self] model in
//            self?.handleSuccess(authMode: model)
//        }
//        .store(in: &cancelable)
    }
    
    func handleSuccess(authMode:AuthModel) {
        self.resultSubject.send(authMode)
        self.resultSubject.send(completion: .finished)
    }
    
    func handleFailure(error:IPETSErrors) {
        resultSubject.send(completion: .failure(error))
    }
    
    func getModel(registerPresentationModel:RegisterPresentationModel) -> RegisterModel {
        
        let registerModel = RegisterModel(name: registerPresentationModel.userName!,
                                          password: registerPresentationModel.password!,
                                          email: registerPresentationModel.mail!,
                                          phone: registerPresentationModel.phone!)
        return registerModel
    }
}
