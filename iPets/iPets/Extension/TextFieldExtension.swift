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
    
     func showHintView(hintString:String) {
         
         
         let xPoint = self.frame.origin.x
         let yPoint = self.frame.origin.y + self.frame.size.height + 2
         let width = self.frame.size.width
         
         let errorView = UIView(frame: CGRect(x: xPoint, y: yPoint, width: width, height: 12))

         let label = UILabel(frame: CGRect(x: 17, y: 0, width: width - 17, height: 12))
         
         label.text = hintString
         label.font = UIFont.systemFont(ofSize: 12)
         label.adjustsFontSizeToFitWidth = true
         label.numberOfLines = 1
         label.textColor = .red
         label.backgroundColor = .clear
         label.clipsToBounds = true
         
         errorView.addSubview(label)

         let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
         
         imgView.image = UIImage(named: "error_icon")
         imgView.contentMode = .scaleAspectFit
         errorView.addSubview(imgView)
         
         self.superview?.addSubview(errorView)
     }
     
     func showError(borderColor:UIColor = .red,borderWidth:CGFloat = CGFloat(1)){
         
         self.layer.borderWidth = borderWidth
         self.layer.borderColor = borderColor.cgColor
         self.layer.cornerRadius = 8
         
     }
     
     func showErrorWithHint(hintString:String,borderColor:UIColor = .red,borderWidth:CGFloat = CGFloat(1)) {
         
         self.showHintView(hintString: hintString)
         self.showError(borderColor:borderColor, borderWidth: borderWidth)
     }
}
