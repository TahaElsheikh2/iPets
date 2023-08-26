//
//  RadialGradientView.swift
//  iPets
//
//  Created by Taha on 19/08/2023.
//

import UIKit

class RadialGradientView: UIView {

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        setupBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientLayer()
        setupBorder()
    }
    
    private func setupGradientLayer() {
        if let gradientLayer = layer as? CAGradientLayer {
            // Define the colors for the gradient
            let colorTop = UIColor(hexaRGB: "FFFFFF",alpha: 0.5)?.cgColor
            let colorBottom = UIColor(hexaRGB: "CEEAFF",alpha: 0.6)?.cgColor
            gradientLayer.colors = [colorTop ?? UIColor.black.cgColor, colorBottom ?? UIColor.black.cgColor]
            
            // Define the start and end points for the gradient (center and radius)
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.type = .radial
        }
    }
    
    private func setupBorder() {
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor(hexaRGB: "CEEAFF")?.cgColor

    }
}
