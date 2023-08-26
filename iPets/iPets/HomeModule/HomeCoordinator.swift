//
//  HomeCoordinator.swift
//  NavigationDemo
//
//  Created by Samuel Samir on 15/06/2023.
//

import UIKit

enum HomeCoordinatorKeys: String {
    case home = "home"
}
class HomeCoordinator: Coordinator {
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
        case HomeCoordinatorKeys.home.rawValue:
            return HomeViewController.instantiate(coordinator: self)
        default:
            return nil
        }
    }
    
}
