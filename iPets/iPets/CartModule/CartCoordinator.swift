//
//  CartCoordinator.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit

enum CartCoordinatorKeys: String {
    case cart = "cart"
}
class CartCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(withKey key: String, andNavigationType type: NavigationType) {
        performNavigationAction(
            with: getViewControllerFromkey(key),
            andKey: key,
            andNavigationType: type
        )
    }
    
    private func getViewControllerFromkey(_ key: String) -> UIViewController?{
        switch key {
        case CartCoordinatorKeys.cart.rawValue:
            return CartViewController.instantiate(coordinator: self)
        default:
            return nil
        }
    }
    
}
