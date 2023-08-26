//
//  ResetPasswordViewController.swift
//  iPets
//
//  Created by Taha on 19/08/2023.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    weak var coordinator: AuthCoordinator?
    @IBOutlet weak var forgetPasswordLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sentButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentView: RadialGradientView!

    
    @IBAction func sentSMSAction(_ sender: Any) {
        coordinator?.navigate(withKey: AuthCoordinatorKeys.verifyEmail.rawValue, andNavigationType: .push)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationItem()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sentButton.setGradientBackground(colorTop: UIColor(hexaRGB: "9ECAEB")!, colorBottom: UIColor(hexaRGB: "7EB2D9")!)
        emailTextField.setupLeftImage(width:25 ,imageName: "smsTextField")
        sentButton.layer.cornerRadius = 8

    }
    

    func setupUI() {
        // Position the text field and button

    }
    
    @IBAction func gotoHomeController(_ sender: Any) {
        coordinator?.navigate(withKey: "home", andNavigationType: .setRoot )
    }
}

extension ResetPasswordViewController: ViewControllerInitializable {
    static func instantiate(coordinator: Coordinator) -> UIViewController {
        let vc = ResetPasswordViewController()
        vc.coordinator = coordinator as? AuthCoordinator
        return vc
    }
}

