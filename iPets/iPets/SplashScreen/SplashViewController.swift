//
//  SplashViewController.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit

class SplashViewController: UIViewController {
    weak var coordinator:AppCoordinator?
    
    var countdownTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(1)
        navigateToNextView()
    }
    
    
    func navigateToNextView() {
        coordinator?.navigate(withKey: "login", andNavigationType: .setRoot)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }

}
