//
//  OnboardingView.swift
//  iPets
//
//  Created by Taha on 15/08/2023.
//

import UIKit

protocol OnboardingViewDelegate {
    func didDisAppear()
}
class OnboardingView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var pageControl: UIPageControl!
    var onboardingCollectionViewCellModelArr = [OnboardingCollectionViewCellModel]()
    var currentPage = 0
    var newPageNumber = 1
    var delegate : OnboardingViewDelegate!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        let nextPageIndex = currentPage + 1
        if nextPageIndex < onboardingCollectionViewCellModelArr.count{
            self.scrollToPageIndex(pageIndex: (nextPageIndex))
        }else{
            delegate.didDisAppear()
        }
    }
    
    @IBAction func pageControlValueChangedAction(_ sender: Any) {
            
        self.scrollToPageIndex(pageIndex: self.pageControl.currentPage)
    }
    
    func scrollToPageIndex(pageIndex:Int) {
        
        self.collectionView.scrollToItem(at: IndexPath(row: pageIndex, section: 0), at: .right, animated: true)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    func commonInit() {
        
        guard let view = Bundle.main.loadNibNamed("OnboardingView", owner: self, options: nil)?[0] as? UIView else {
            return
        }
        
        view.frame = bounds
        self.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        self.addSubview(view)
        
        self.setupCollectionView()
        self.collectionView.allowsMultipleSelection = true
        self.buildUpOnboardingModel()
        self.pageControl.numberOfPages = self.onboardingCollectionViewCellModelArr.count
    }
    
    func buildUpOnboardingModel(){
        var model1 = OnboardingCollectionViewCellModel()
        model1.img = UIImage(named: "onboarding1")
        var attrStr1 = "Track Your pet’s health".makeAttributedStr(bold: true, color: UIColor.black, fontSize: 16)
        let spacing = "\n \n".makeAttributedStr(bold: false, color: UIColor.black, fontSize: 14)
        let attrStr2 = "Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet Lorem ipsum dolo".makeAttributedStr(bold: false, color: UIColor.black, fontSize: 14)
        attrStr1.append(spacing)
        attrStr1.append(attrStr2)
        model1.desc = attrStr1
        
        var model2 = OnboardingCollectionViewCellModel()
        model2.img = UIImage(named: "onboarding2")
        attrStr1 = "Get Your Pets favourite food".makeAttributedStr(bold: true, color: UIColor.black, fontSize: 16)
        attrStr1.append(spacing)
        attrStr1.append(attrStr2)
        model2.desc = attrStr1
        
        var model3 = OnboardingCollectionViewCellModel()
        model3.img = UIImage(named: "onboarding3")
        attrStr1 = "Find the nearest clinics".makeAttributedStr(bold: true, color: UIColor.black, fontSize: 16)
        attrStr1.append(spacing)
        attrStr1.append(attrStr2)
        model3.desc = attrStr1
                
        self.onboardingCollectionViewCellModelArr = [model1,model2,model3]

    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName:"OnboardingCollectionViewCell", bundle:nil), forCellWithReuseIdentifier:"OnboardingCollectionViewCell")
    }
}

extension OnboardingView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.onboardingCollectionViewCellModelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell

        cell.setModel(model: self.onboardingCollectionViewCellModelArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        newPageNumber = indexPath.row
        print("### collectionView willDisplay = \(indexPath.row)")

    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == currentPage{
            currentPage = newPageNumber
        }
        print("### collectionView didEndDisplaying = \(indexPath.row)")
        print("### collectionView didEndDisplaying currentPage = \(currentPage)")
        pageControl.currentPage = self.currentPage
    }
}

extension String{
    
    func makeAttributedStr(bold: Bool, color:UIColor, fontSize:CGFloat) -> NSMutableAttributedString {
        
        var defaultFont = UIFont.systemFont(ofSize: fontSize)
        
        if bold {
            defaultFont = UIFont.boldSystemFont(ofSize: fontSize)
        }
        
        let titleAttributes = [NSAttributedString.Key.font: defaultFont as Any, NSAttributedString.Key.foregroundColor: color]
        
        var titleStr = NSMutableAttributedString()
        titleStr = NSMutableAttributedString(string: "\(self) ", attributes: titleAttributes)
        
        return titleStr
    }
}
