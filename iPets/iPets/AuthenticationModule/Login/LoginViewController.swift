//
//  LoginViewController.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit

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
    
    func didDisAppear() {
        self.onboardingView.removeFromSuperview()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    let onboardingView = OnboardingView()
    
    var viewModel: LoginViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.setupLeftImage(imageName: "userTextField")
        passwordTextField.setupLeftImage(imageName: "passwordTextField")
        passwordTextField.isSecureTextEntry = true
        loginButton.setGradientBackground(colorTop: UIColor(hexaRGB: "9ECAEB")!, colorBottom: UIColor(hexaRGB: "7EB2D9")!)
        loginButton.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        onboardingView.frame = self.view.frame
        onboardingView.delegate = self
        setNavigationItem()
    }
    
    @IBAction func gotoRegisterViewController(_ sender: Any) {
        viewModel!.gotoRegisterViewController()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        let email = self.userNameTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
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
        CacheHandler.deleteStringFromKeychain(forKey: CacheConstants.Token_Constant)
    }
    
    @IBAction func appleAction(_ sender: Any) {
        checkToken()
    }
    func checkToken() {
    
        
        print("###!! checkToken TokenManager().getCachedToken() = \(TokenManager().getCachedToken()))")
        print("###!! checkToken TokenManager().isValidToken() = \(TokenManager().isValidToken()))")
        print("###!! checkToken CacheManager().Email_Constant() = \(CacheHandler.getStringFromKeychain(forKey: CacheConstants.Email_Constant)))")
        print("###!! checkToken CacheManager().Password_Constant() = \(CacheHandler.getStringFromKeychain(forKey: CacheConstants.Password_Constant)))")

    }
    @IBAction func createAccountAction(_ sender: Any) {
        viewModel?.gotoRegisterViewController()
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

