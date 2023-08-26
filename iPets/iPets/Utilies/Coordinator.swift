//
//  Coordinator.swift
//  iPets
//
//  Created by Taha on 10/08/2023.
//

import UIKit

enum NavigationType {
    case push
    case present
    case setRoot
}
protocol Coordinator:AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func navigate(withKey key: String, andNavigationType type: NavigationType)
    func performNavigationAction(
        with viewController: UIViewController? ,
        andKey key: String,
        andNavigationType type: NavigationType
    )
    
    func popToRoot(animated: Bool)
    func popBack(count: Int, animated: Bool)
    func popToViewController<T: UIViewController>(_ targetViewControllerType: T.Type, animated: Bool)
}


extension Coordinator {
    private func delegateNavigationToAppCoordinator(withKey key: String, andNavigationType type: NavigationType) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.coordinator?.navigate(withKey: key, andNavigationType: type)
        }
    }
    
    func performNavigationAction(
        with viewController: UIViewController? ,
        andKey key: String,
        andNavigationType type: NavigationType
    ){
        print("performNavigationAction")
        guard let viewController = viewController else {
            delegateNavigationToAppCoordinator(withKey: key, andNavigationType: type)
            return
        }
        switch type {
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        case .present:
            navigationController.present(viewController, animated: true, completion: nil)
        case .setRoot:
            if let appDelegate =  UIApplication.shared.delegate as? AppDelegate {
                navigationController.setViewControllers([viewController], animated: false)
                appDelegate.window?.rootViewController = navigationController
            }
        }
    }
    
    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func popToViewController<T: UIViewController>(_ targetViewControllerType: T.Type, animated: Bool) {
        if let targetViewController = navigationController.viewControllers.first(where: { $0 is T }) {
            navigationController.popToViewController(targetViewController, animated: animated)
        }
    }
    
    func popBack(count: Int, animated: Bool) {

        let viewControllersCount = navigationController.viewControllers.count
        let targetIndex = max(0, viewControllersCount - count)
        let targetViewController = navigationController.viewControllers[targetIndex]
        
        navigationController.popToViewController(targetViewController, animated: animated)
    }
    
  
}

