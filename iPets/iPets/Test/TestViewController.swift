//
//  TestViewController.swift
//  iPets
//
//  Created by Taha on 23/08/2023.
//

import UIKit

class TestViewController: UIViewController {
    weak var coordinator: AuthCoordinator?

    var testFunc = TestFuncs()
    
    @IBOutlet weak var countPrimeNumberButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func countPrimeNumber(_ sender: Any) {
        
//        let storyRepo = StoreRepo()
//        storyRepo.fetchStoriesByUsername(username: "", limit: 3, pageNumber: 2) { model in
//            print("#### model = \(model?.first?.title)")
//        } failureCompletion: { errorString in
//            print("#### errorString = \(errorString)")
//        }
        
//        testFunc.makePostRequest()
        let registerRepo = RegisterRepo()
        registerRepo.registerAction(successCompletion: { model in
            print("#### model.userName = \(model?.data?.userName)")
            print("#### model type= \(model?.data?.type)")
            print("#### model token= \(model?.data?.token)")
            print("#### model email= \(model?.data?.email)")
            print("#### model id= \(model?.data?.id)")

        }, failureCompletion: { errorString in
            print("#### errorString = \(errorString)")

        })
        
//        testFunc.sampleDownload { data in
//            guard let data = data else{
//                print("Data is nil")
//                return
//            }
//            OperationQueue.main.addOperation {
//                self.setImage(data: data)
//            }
//
//        }
    }
    func setImage(data:Data){
        
        let imageView = UIImageView(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
        let image = UIImage(data: data)
        imageView.image = image
        self.view.addSubview(imageView)
        
        
    }

}
extension TestViewController: ViewControllerInitializable {
    static func instantiate(coordinator: Coordinator) -> UIViewController {
        let vc = TestViewController()
        vc.coordinator = coordinator as? AuthCoordinator
        return vc
    }
}
