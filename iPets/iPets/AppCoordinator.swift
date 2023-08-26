//
//  AppCoordinator.swift
//  iPets
//
//  Created by Taha on 10/08/2023.
//

import Foundation
import UIKit


class AppCoordinator: NSObject, Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = SplashViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func navigate(withKey key: String, andNavigationType type: NavigationType) {
        let module = MainModulesHelper.shared.getModules(key: key)
        switch module {
        case .app:
            start()
        case .auth:
            let child = AuthCoordinator(navigationController: navigationController)
            childCoordinators.append(child)
            child.navigate(withKey: key, andNavigationType: type)
        case .home:
            let child = HomeCoordinator(navigationController: navigationController)
            childCoordinators.append(child)
            child.navigate(withKey: key, andNavigationType: type)
            break
        case .cart:
            let child = CartCoordinator(navigationController: navigationController)
            childCoordinators.append(child)
            child.navigate(withKey: key, andNavigationType: type)
            break
        case .non:
            print("This Key Doesn't Exist at the app")
            break
        }
        
    }
}
extension AppCoordinator:  UINavigationControllerDelegate {
    func childDidFinish(_ child: Coordinator?) {
        print("Num of childCoordinators 1 : --> \(childCoordinators.count)")
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        print("Num of childCoordinators 2 : --> \(childCoordinators.count)")
        
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("Num of childCoordinators  : --> \(childCoordinators.count)")
        print("navigationController \(viewController.self)")
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        print("fromViewController \(fromViewController.self)")
        
        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
//        if let buyViewController = fromViewController as? PaymentViewController {
//            // We're popping a buy view controller; end its coordinator
//            childDidFinish(buyViewController.coordinator)
//        }
    }
    
}
