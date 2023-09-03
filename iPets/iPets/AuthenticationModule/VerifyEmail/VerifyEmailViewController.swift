//
//  VerifyEmailViewController.swift
//  iPets
//
//  Created by Taha on 19/08/2023.
//

import UIKit
import Combine

class VerifyEmailViewController: UIViewController {
    weak var coordinator: AuthCoordinator?
    let viewModel = VerifyEmailViewModel()
    var cancelable = Set<AnyCancellable>()
    @IBOutlet weak var verifyMailLabel: UILabel!
    @IBOutlet weak var contentView: RadialGradientView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstTextField: SingleDigitField!
    @IBOutlet weak var secondTextField: SingleDigitField!
    @IBOutlet weak var thirdTextField: SingleDigitField!
    @IBOutlet weak var fourthTextField: SingleDigitField!
    @IBOutlet weak var fifthTextField: SingleDigitField!
    @IBOutlet weak var sixthTextField: SingleDigitField!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationItem()
        
    }
}


//MARK: - UI
extension VerifyEmailViewController{
    
    func setupUI() {
        self.clearTextFields()
        verifyButton.setGradientBackground(colorTop: UIColor(hexaRGB: "9ECAEB")!, colorBottom: UIColor(hexaRGB: "7EB2D9")!)
        verifyButton.layer.cornerRadius = 8
        self.infoLabel.text = "Please enter the 6 digit code sent to \(self.viewModel.getEmailString())"
        self.verifyButton.isEnabled = false
        self.resendButton.isEnabled = false
        self.viewModel.startCountdown()
        self.subscribeOnTimer()
        self.subscribeOnTimerLabelIsEnabledFlag()
    }
    
    func clearTextFields() {
        [firstTextField, secondTextField, thirdTextField, fourthTextField,fifthTextField,sixthTextField].forEach {
            $0?.text = ""
            $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
        firstTextField.isUserInteractionEnabled = true
        firstTextField.becomeFirstResponder()
    }
}

//MARK: - Actions
extension VerifyEmailViewController{
    
    @IBAction func verifyAction(_ sender: Any) {
        self.verify()
    }
    
    func verify() {
        let code = self.getVerificationCode()
        
        var  verifyEmailDTO = VerifyEmailDTO()
        verifyEmailDTO.code = code
        print("## verify code = \(code)")
        self.verifyAction(model: verifyEmailDTO)
    }
    
    func verifyAction(model:VerifyEmailDTO) {
        self.viewModel.verifyEmail(verifyEmailDTO: model)
            .sink(receiveCompletion: {[weak self] result in
                switch result{
                case .finished:
                    self?.handleSuccess()
                case .failure(let error):
                    self?.handleFailure(error: error)
                }
            }, receiveValue: {model in
                print("receiveValue model = \(model)")
            }).store(in: &cancelable)
    }
    
    func handleSuccess(){
        
        print("## result finished)")
        self.gotoHomeController()
    }
    
    func handleFailure(error:IPETSErrors) {
        
        print("## failure error = \(error.localizedDescription)")
        self.showAlert(title: "error", message: error.localizedDescription, actionTitle: "Ok")
        self.clearTextFields()
    }
    
    func getVerificationCode() -> String {
        
        var verificationCode = firstTextField.text ?? ""
        verificationCode += secondTextField.text ?? ""
        verificationCode += thirdTextField.text ?? ""
        verificationCode += fourthTextField.text ?? ""
        verificationCode += fifthTextField.text ?? ""
        verificationCode += sixthTextField.text ?? ""
        
        return verificationCode
    }
    
    @IBAction func resendAction(_ sender: Any) {
        self.clearTextFields()
        self.viewModel.startCountdown()
        self.resendAction()
    }
    
    func resendAction() {
        
        self.viewModel.resendVerifyCode()
            .sink(receiveCompletion: {[weak self] result in
                switch result{
                case .finished:
                    self?.handleSuccess()
                case .failure(let error):
                    self?.handleFailure(error: error)
                }
            }, receiveValue: {model in
                print("receiveValue model = \(model)")
            }).store(in: &cancelable)
    }
}

//MARK: - Subscriptions
extension VerifyEmailViewController{
    
    func subscribeOnTimer() {
        
        self.viewModel.timerPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {timeValue in
            
            self.counterLabel.text = "0:\(timeValue)"
        }).store(in: &cancelable)
    }
    
    func subscribeOnTimerLabelIsEnabledFlag() {
        self.viewModel.timerLabelIsEnabledFlagPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {isEnable in
  
            self.resendButton.isEnabled = isEnable
        }).store(in: &cancelable)
    }
}

//MARK: - Handle UITextFields
extension VerifyEmailViewController{
   
    @objc func editingChanged(_ textField: SingleDigitField) {
        if textField.pressedDelete {
            textField.pressedDelete = false
            if textField.hasText {
                textField.text = ""
            } else {
                switch textField {
                case secondTextField, thirdTextField, fourthTextField,fifthTextField,sixthTextField:
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
                    case fifthTextField:
                        fourthTextField.isUserInteractionEnabled = true
                        fourthTextField.becomeFirstResponder()
                        fourthTextField.text = ""
                    case sixthTextField:
                        fifthTextField.isUserInteractionEnabled = true
                        fifthTextField.becomeFirstResponder()
                        fifthTextField.text = ""
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
        case firstTextField, secondTextField, thirdTextField,fourthTextField,fifthTextField:
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
            case fourthTextField:
                fifthTextField.isUserInteractionEnabled = true
                fifthTextField.becomeFirstResponder()
            case fifthTextField:
                sixthTextField.isUserInteractionEnabled = true
                sixthTextField.becomeFirstResponder()
            default: break
            }
        case sixthTextField:
            sixthTextField.resignFirstResponder()
            self.verifyButton.isEnabled = true
            self.verify()
        default: break
        }
    }
}

//MARK: - Navigation
extension VerifyEmailViewController{
    
    func gotoHomeController() {
        coordinator?.navigate(withKey: AuthCoordinatorKeys.TestViewController.rawValue, andNavigationType: .push)
    }
}


extension VerifyEmailViewController: ViewControllerInitializable {
    static func instantiate(coordinator: Coordinator) -> UIViewController {
        let vc = VerifyEmailViewController()
        vc.coordinator = coordinator as? AuthCoordinator
        return vc
    }
}
