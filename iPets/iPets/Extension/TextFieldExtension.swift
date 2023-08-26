//
//  TextFieldExtension.swift
//  iPets
//
//  Created by Taha on 19/08/2023.
//

import UIKit

extension UITextField {
    
    //MARK:- Set Image on the right of text fields
    
    func setupRightImage(imageName:String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageContainerView.addSubview(imageView)
        rightView = imageContainerView
        rightViewMode = .always
        self.tintColor = .lightGray
    }
    
    //MARK:- Set Image on left of text fields
    
    func setupLeftImage(width:CGFloat = 16,imageName:String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: width, height: 19))
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: (width + 15), height: 40))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
    
}
