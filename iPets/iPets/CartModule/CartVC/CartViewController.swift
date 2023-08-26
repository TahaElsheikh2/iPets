//
//  CartViewController.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit

class CartViewController: UIViewController {
    weak var coordinator: CartCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CartViewController"
    }
    
    @IBAction func popAction(_ sender: Any) {
//        coordinator?.popToRoot(animated: true)
        coordinator?.popToViewController(HomeViewController.self, animated: true)
//        coordinator?.popBack(count: 1, animated: true)
    }
    

}
extension CartViewController: ViewControllerInitializable {
    static func instantiate(coordinator: Coordinator) -> UIViewController {
        let vc = CartViewController()
        vc.coordinator = coordinator as? CartCoordinator
        return vc
    }
}
