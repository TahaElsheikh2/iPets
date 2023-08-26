//
//  HomeViewController.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit

class HomeViewController: UIViewController {

    weak var coordinator: HomeCoordinator?
    @IBOutlet weak var keyTextFiled: UITextField!
    @IBOutlet weak var appKeysLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HomeViewController"
        appKeysLabel.numberOfLines = 0
        let keys = "login  - register - home - cart"
        appKeysLabel.text = keys
        keyTextFiled.placeholder = "Enter navigation key, please select from the above keys"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func pushAction(_ sender: Any) {
        if let text = keyTextFiled.text {
            coordinator?.navigate(withKey: text.lowercased(), andNavigationType: .push)
        }
    }
    
    @IBAction func presentAction(_ sender: Any) {
        if let text = keyTextFiled.text {
            coordinator?.navigate(withKey: text.lowercased(), andNavigationType: .present)
        }
    }
    
    @IBAction func setRootAction(_ sender: Any) {
        if let text = keyTextFiled.text {
            coordinator?.navigate(withKey: text.lowercased(), andNavigationType: .setRoot)
        }
    }
}
extension HomeViewController: ViewControllerInitializable {
    static func instantiate(coordinator: Coordinator) -> UIViewController {
        let vc = HomeViewController()
        vc.coordinator = coordinator as? HomeCoordinator
        return vc
    }
}

