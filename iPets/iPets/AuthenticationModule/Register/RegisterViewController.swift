//
//  RegisterViewController.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit
struct RegisterPresentationModel {
    var userName : String?
    var mail : String?
    var phone : String?
    var password : String?
    var confirmPassword : String?
}

class RegisterViewModel {
    func registerAction(model:RegisterPresentationModel, success:() -> Void, failure: () -> Void) {
        let registerUseCase: RegisterUseCaseProtocol = RegisterUseCase()
        
        let registerModel = getModel(registerPresentationModel: model)
        registerUseCase.registerWith(registerModel: registerModel, successCompletion: { model in
            print("#### model.userName = \(model.data?.userName)")
            print("#### model type= \(model.data?.type)")
            print("#### model token= \(model.data?.token)")
            print("#### model email= \(model.data?.email)")
            print("#### model id= \(model.data?.id)")

        }, failureCompletion: { error in
            print("#### error.desc = \(error.errorDesc)")
            print("#### error.errorCode = \(error.errorCode)")

        })
    }
    
    func getModel(registerPresentationModel:RegisterPresentationModel) -> RegisterModel {
        
        let registerModel = RegisterModel(name: registerPresentationModel.userName!,
                                          password: registerPresentationModel.password!,
                                          email: registerPresentationModel.mail!,
                                          phone: registerPresentationModel.phone!)
        return registerModel
    }
}

class RegisterViewController: UIViewController {
    weak var coordinator: AuthCoordinator?
    let viewModel = RegisterViewModel()
    
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var contentView: RadialGradientView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var gmailButton: UIButton!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    @IBOutlet weak var goToLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationItem()
    }

    func setupUI() {
        
        userNameTextField.setupLeftImage(imageName: "userTextField")
        passwordTextField.setupLeftImage(imageName: "passwordTextField")
        confirmPasswordTextField.setupLeftImage(imageName: "passwordTextField")
        emailTextField.setupLeftImage(imageName: "smsTextField")
        phoneTextField.setupLeftImage(imageName: "egypt")
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        registerButton.setGradientBackground(colorTop: UIColor(hexaRGB: "9ECAEB")!, colorBottom: UIColor(hexaRGB: "7EB2D9")!)
        registerButton.layer.cornerRadius = 8
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let model = getRegisterModel()
        
        self.viewModel.registerAction(model: model) {
            print("###$$ viewModel registerAction Success")
            self.navigateToVerifyEmailPage()
        } failure: {
            print("###$$ viewModel registerAction failure")
        }
    }
    
    func getRegisterModel() -> RegisterPresentationModel {
      
        let model = RegisterPresentationModel(userName: userNameTextField.text,
                                              mail: emailTextField.text,
                                              phone: phoneTextField.text,
                                              password: passwordTextField.text,
                                              confirmPassword: confirmPasswordTextField.text)
        return model
    }
    
    func navigateToVerifyEmailPage() {
        coordinator?.navigate(withKey: AuthCoordinatorKeys.verifyEmail.rawValue, andNavigationType: .push)
    }
    
    @IBAction func goToLoginAction(_ sender: Any) {
        coordinator?.navigate(withKey: AuthCoordinatorKeys.login.rawValue, andNavigationType: .setRoot)

    }
//
//    @IBAction func gotoHomeController(_ sender: Any) {
//        coordinator?.navigate(withKey: "home", andNavigationType: .setRoot )
//    }
}
extension RegisterViewController: ViewControllerInitializable {
    static func instantiate(coordinator: Coordinator) -> UIViewController {
        let vc = RegisterViewController()
        vc.coordinator = coordinator as? AuthCoordinator
        return vc
    }
}

