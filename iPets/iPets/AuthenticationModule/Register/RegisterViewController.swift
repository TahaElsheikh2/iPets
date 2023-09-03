//
//  RegisterViewController.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit
import Combine
class RegisterViewController: UIViewController {
    weak var coordinator: AuthCoordinator?
    let viewModel = RegisterViewModel()
    var cancelable = Set<AnyCancellable>()

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

    func setupSubscription(){
    
        viewModel.resultSubject.sink { complete in
            switch complete{
            case .finished:
                print("finished")
                self.navigateToVerifyEmailPage()
            case .failure(let error):
                self.showError(error:error)
            }
        } receiveValue: { model in
            print("receiveValue = \(model)")
        }.store(in: &cancelable)

    }
    func showError(error:IPETSErrors) {
        
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
        
        self.viewModel.registerAction(model: model)
            .receive(on: DispatchQueue.main)
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
            .sink {[weak self] complete in
                switch complete{
                case .finished:
                    self?.handleSuccess()
                    print("finished")
                case .failure(let error):
                    self?.handleFailure(error: error)
                    print("error = \(error.localizedDescription)")
                }
            } receiveValue: {[weak self] model in
                print("receiveValue model = \(model)")
            }
            .store(in: &cancelable)
    }
    
    func handleSuccess() {
        self.navigateToVerifyEmailPage()
    }
    
    func handleFailure(error:IPETSErrors) {
        self.showAlert(title: "oops", message: error.localizedDescription, actionTitle: "Ok")
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

