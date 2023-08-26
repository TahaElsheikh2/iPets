//
//  VerifyEmailViewController.swift
//  iPets
//
//  Created by Taha on 19/08/2023.
//

import UIKit

class VerifyEmailViewController: UIViewController {
    weak var coordinator: AuthCoordinator?

    @IBOutlet weak var verifyMailLabel: UILabel!
    @IBOutlet weak var contentView: RadialGradientView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var firstTextField: SingleDigitField!
    @IBOutlet weak var secondTextField: SingleDigitField!
    @IBOutlet weak var thirdTextField: SingleDigitField!
    @IBOutlet weak var fourthTextField: SingleDigitField!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        [firstTextField, secondTextField, thirdTextField, fourthTextField].forEach {
            $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
        firstTextField.isUserInteractionEnabled = true
        firstTextField.becomeFirstResponder()
        verifyButton.setGradientBackground(colorTop: UIColor(hexaRGB: "9ECAEB")!, colorBottom: UIColor(hexaRGB: "7EB2D9")!)
        verifyButton.layer.cornerRadius = 8

    }
    @objc func editingChanged(_ textField: SingleDigitField) {
        if textField.pressedDelete {
            textField.pressedDelete = false
            if textField.hasText {
                textField.text = ""
            } else {
                switch textField {
                case secondTextField, thirdTextField, fourthTextField:
                    textField.resignFirstResponder()
                    textField.isUserInteractionEnabled = false
                    switch textField {
                    case secondTextField:
                        firstTextField.isUserInteractionEnabled = true
                        firstTextField.becomeFirstResponder()
                        firstTextField.text = ""
                    case thirdTextField:
                        secondTextField.isUserInteractionEnabled = true
                        secondTextField.becomeFirstResponder()
                        secondTextField.text = ""
                    case fourthTextField:
                        thirdTextField.isUserInteractionEnabled = true
                        thirdTextField.becomeFirstResponder()
                        thirdTextField.text = ""
                    default:
                        break
                    }
                default: break
                }
            }
        }

        guard textField.text?.count == 1, textField.text?.last?.isWholeNumber == true else {
            textField.text = ""
            return
        }
        switch textField {
        case firstTextField, secondTextField, thirdTextField:
            textField.resignFirstResponder()
            textField.isUserInteractionEnabled = false
            switch textField {
            case firstTextField:
                secondTextField.isUserInteractionEnabled = true
                secondTextField.becomeFirstResponder()
            case secondTextField:
                thirdTextField.isUserInteractionEnabled = true
                thirdTextField.becomeFirstResponder()
            case thirdTextField:
                fourthTextField.isUserInteractionEnabled = true
                fourthTextField.becomeFirstResponder()
            default: break
            }
        case fourthTextField:
            fourthTextField.resignFirstResponder()
            self.verify()
        default: break
        }
    }
    
    func verify() {
        print("verify")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationItem()

    }
    @IBAction func resendAction(_ sender: Any) {
    }
    
    @IBAction func verifyAction(_ sender: Any) {
    }

    

    func setupUI() {
        // Position the text field and button

    }
    
    @IBAction func gotoHomeController(_ sender: Any) {
        coordinator?.navigate(withKey: "home", andNavigationType: .setRoot )
    }
}

extension VerifyEmailViewController: ViewControllerInitializable {
    static func instantiate(coordinator: Coordinator) -> UIViewController {
        let vc = VerifyEmailViewController()
        vc.coordinator = coordinator as? AuthCoordinator
        return vc
    }
}

