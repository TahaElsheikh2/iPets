//
//  RegisterViewController.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit


class RegisterViewController: UIViewController {
    weak var coordinator: AuthCoordinator?
    
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var contentView: RadialGradientView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var gmailButton: UIButton!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    @IBOutlet weak var goToLoginButton: UIButton!

    @IBAction func registerAction(_ sender: Any) {
    }
    
    @IBAction func goToLoginAction(_ sender: Any) {
        coordinator?.navigate(withKey: AuthCoordinatorKeys.login.rawValue, andNavigationType: .setRoot)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationItem()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.setupLeftImage(imageName: "userTextField")
        passwordTextField.setupLeftImage(imageName: "passwordTextField")
        confirmPasswordTextField.setupLeftImage(imageName: "passwordTextField")
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        registerButton.setGradientBackground(colorTop: UIColor(hexaRGB: "9ECAEB")!, colorBottom: UIColor(hexaRGB: "7EB2D9")!)
        registerButton.layer.cornerRadius = 8

    }
    

    func setupUI() {
        // Position the text field and button

    }
    
    @IBAction func gotoHomeController(_ sender: Any) {
        coordinator?.navigate(withKey: "home", andNavigationType: .setRoot )
    }
}
extension RegisterViewController: ViewControllerInitializable {
    static func instantiate(coordinator: Coordinator) -> UIViewController {
        let vc = RegisterViewController()
        vc.coordinator = coordinator as? AuthCoordinator
        return vc
    }
}

