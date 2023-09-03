//
//  VerifyEmailViewModel.swift
//  iPets
//
//  Created by Taha on 03/09/2023.
//

import Foundation
import Combine
class VerifyEmailViewModel{
    
    var useCase : VerifyEmailUseCaseProtocol
    var resendVerifyCodeUseCase : ResendVerifyCodeUseCaseProtocol
    
    init(useCase: VerifyEmailUseCaseProtocol = VerifyEmailUseCase(),
         resendVerifyCodeUseCase : ResendVerifyCodeUseCaseProtocol = ResendVerifyCodeUseCase()) {
        self.useCase = useCase
        self.resendVerifyCodeUseCase = resendVerifyCodeUseCase
    }
    
//    func legacyVerifyEmail(verifyEmailDTO: VerifyEmailDTO){
//
//        self.useCase.legacyVerifyEmail(verifyEmailDTO: verifyEmailDTO) { model in
//
//            print("#### model.userName = \(model.data?.userName)")
//            print("#### model type= \(model.data?.type)")
//            print("#### model token= \(model.data?.token)")
//            print("#### model email= \(model.data?.email)")
//            print("#### model id= \(model.data?.id)")
//
//        } failureCompletion: { error in
//            print("#### error.desc = \(error.errorDesc)")
//            print("#### error.errorCode = \(error.errorCode)")
//        }
//    }
    
    func verifyEmail(verifyEmailDTO: VerifyEmailDTO) -> AnyPublisher<AuthModel,IPETSErrors> {
        
        return self.useCase.verifyEmail(verifyEmailDTO: verifyEmailDTO)
    }
    
    func resendVerifyCode() -> AnyPublisher<AuthModel,IPETSErrors> {
        
        return self.resendVerifyCodeUseCase.resendVerifyCode()
    }
    
    func getEmailString() -> String {
        
       let email = CacheHandler.getStringFromKeychain(forKey: CacheConstants.Email_Constant) ?? ""
        return email
    }
    
    private var countdown = 0
    var timerSubject = PassthroughSubject<Int,Never>()
    var timerLabelIsEnabledFlagSubject = PassthroughSubject<Bool,Never>()

       private var timer: AnyCancellable?
       
    func startCountdown() {
        countdown = 60
        timerLabelIsEnabledFlagSubject.send(false)
           timer = Timer.publish(every: 1, on: .main, in: .default)
               .autoconnect()
               .sink { [weak self] _ in
                   guard let self = self else { return }
                   if self.countdown > 0 {
                       self.countdown -= 1
                       self.timerSubject.send(self.countdown)
                   } else {
                       self.timerLabelIsEnabledFlagSubject.send(true)
                       self.timer?.cancel()
                   }
               }
       }
}
