//
//  UIViewControllerExtension.swift
//  iPets
//
//  Created by Taha on 19/08/2023.
//

import UIKit

extension UIViewController {
    func setNavigationItem(name:String = "Pettsy") {
        let imageView = UIImageView(image: UIImage(named: name))
        self.navigationItem.titleView = imageView
    }
    
    func showAlert(title:String,message:String,actionTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            print("Alert 1 action pressed")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)

    }
}
