//
//  OnboardingCollectionViewCell.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setModel(model:OnboardingCollectionViewCellModel) {
        self.containerView.backgroundColor = model.backGroundColor
        self.descLabel.attributedText = model.desc
        guard let img = model.img else { return  }
        self.imgView.image = img

    }
}

struct OnboardingCollectionViewCellModel {
    var backGroundColor = UIColor.white
    var img : UIImage!
    var desc = "".makeAttributedStr(bold: false, color: UIColor.black, fontSize: 16)
    
}
