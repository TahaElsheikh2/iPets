//
//  LoginViewController.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit

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
    
    func loginAction(loginModel:LoginModelDTO, successCompletion:@escaping (AuthModel) -> Void, failureCompletion:@escaping (CustomError) -> Void) {
        
        self.loginUseCase.login(loginModelDTO: loginModel) {[weak self] model in
            
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

class LoginViewController: UIViewController ,OnboardingViewDelegate {
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var contentView: RadialGradientView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var gmailButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!

    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let email = userNameTextField.text else {
            print("email = nil")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("password = nil")
            return
        }
        viewModel?.loginAction(loginModel: LoginModelDTO(email: email,password: password), successCompletion: { model in

        }, failureCompletion:{ error in
            print("####$ LoginViewController LoginAction error")
        })
    }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        viewModel?.gotoResetPasswordVC()
    }

    @IBAction func gmailAction(_ sender: Any) {
        viewModel?.goToHome()
    }
    
    @IBAction func facebookAction(_ sender: Any) {
    }
    
    @IBAction func appleAction(_ sender: Any) {
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        viewModel?.gotoRegisterViewController()
    }
    
    func didDisAppear() {
        self.onboardingView.removeFromSuperview()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    let onboardingView = OnboardingView()

    var viewModel: LoginViewModel?
    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        userNameTextField.setupLeftImage(imageName: "userTextField")
        passwordTextField.setupLeftImage(imageName: "passwordTextField")
        passwordTextField.isSecureTextEntry = true
        loginButton.setGradientBackground(colorTop: UIColor(hexaRGB: "9ECAEB")!, colorBottom: UIColor(hexaRGB: "7EB2D9")!)
        loginButton.layer.cornerRadius = 8
    }
    
    @IBAction func gotoRegisterViewController(_ sender: Any) {
        viewModel!.gotoRegisterViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        onboardingView.frame = self.view.frame
        onboardingView.delegate = self
        setNavigationItem()
        
    }
}

extension LoginViewController: ViewControllerInitializable {
    static func instantiate(coordinator: Coordinator) -> UIViewController {
        let vc = LoginViewController()
        let vm = LoginViewModel(coordinator: coordinator as! AuthCoordinator)
        vc.viewModel = vm
        return vc
    }
}

