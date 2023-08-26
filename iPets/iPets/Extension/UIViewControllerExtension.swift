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
}
