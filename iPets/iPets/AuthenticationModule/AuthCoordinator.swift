//
//  AuthCoordinator.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//


import UIKit

enum AuthCoordinatorKeys: String {
    case login = "login"
    case register = "register"
    case resetPassword = "resetPassword"
    case verifyEmail = "verifyEmail"
    case TestViewController = "TestViewController"
}
class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(withKey key: String, andNavigationType type: NavigationType) {
        performNavigationAction(
            with: getViewControllerFromkey(key),
            andKey: key,
            andNavigationType: type
        )
    }
    
    func backFromRegisterViewController(data: String) {
        if let topViewController = navigationController.topViewController  as? LoginViewController{
        }
    }
}

//MARK: ViewControllers
extension AuthCoordinator {
    private func getViewControllerFromkey(_ key: String) -> UIViewController?{
        switch key {
        case AuthCoordinatorKeys.login.rawValue:
            return LoginViewController.instantiate(coordinator: self)
        case AuthCoordinatorKeys.register.rawValue:
            return RegisterViewController.instantiate(coordinator: self)
        case AuthCoordinatorKeys.resetPassword.rawValue:
            return ResetPasswordViewController.instantiate(coordinator: self)
        case AuthCoordinatorKeys.verifyEmail.rawValue:
            return VerifyEmailViewController.instantiate(coordinator: self)
        case AuthCoordinatorKeys.TestViewController.rawValue:
            return TestViewController.instantiate(coordinator: self)
        default:
            return nil
        }
    }

}
