//
//  LoginViewModel.swift
//  iPets
//
//  Created by Taha on 28/08/2023.
//

import Foundation
import Combine
protocol LoginViewModelProtocol {
    func gotoRegisterViewController()
}

class LoginViewModel:LoginViewModelProtocol {
    weak var coordinator: AuthCoordinator?
    var loginUseCase : LoginUseCaseProtocol
    
    
    init(coordinator: AuthCoordinator,loginUseCase : LoginUseCaseProtocol = LoginUseCase()) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
    }

    func validateCredential(loginModel:LoginModelDTO) -> (showEmailError:Bool,showPasswordError:Bool){
        var showEmailError = true
        var showPasswordError = true
        if loginModel.email.isValidEmail() {
            showEmailError = false
        }
        if loginModel.password.isValidPassword(){
            showPasswordError = false
        }
        return(showEmailError:showEmailError, showPasswordError:showPasswordError)
    }
    
    
    
    func loginAction(loginModel:LoginModelDTO, successCompletion:@escaping (AuthModelDTO) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.loginUseCase.legacyLogin(loginModelDTO: loginModel) {[weak self] model in
            
            guard let self = self else{
                return
            }
            
            print("####$ LoginViewModel LoginAction Success with Token = \(String(describing: model.data?.token))")
            successCompletion(model)
            self.goToHome()
            
        } failureCompletion: { error in
            print("####$ LoginViewModel LoginAction error")
            failureCompletion(error)
        }

    }
    
    func goToHome() {
        coordinator?.navigate(withKey: AuthCoordinatorKeys.TestViewController.rawValue, andNavigationType: .push)
    }
    
    func gotoRegisterViewController(){
        coordinator?.navigate(withKey: AuthCoordinatorKeys.register.rawValue, andNavigationType: .push)
    }
    
    func gotoResetPasswordVC(){
        coordinator?.navigate(withKey: AuthCoordinatorKeys.resetPassword.rawValue, andNavigationType: .push)
    }
    
    
}
