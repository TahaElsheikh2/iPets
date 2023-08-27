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

        self.getAllPetsTypes()

    }
    
    func getAllPets()  {
        let getAllPetsUseCase: GetAllPetsUseCaseProtocol = GetAllPetsUseCase()
        getAllPetsUseCase.getAllPets { model in
            
            print("###!! model.message = \(String(describing: model.message))")
            print("###!! model.status = \(String(describing: model.status))")
            print("###!! model.data = \(String(describing: model.data))")
            print("###!! model.data?.first?.petName = \(String(describing: model.data?.first?.petName))")
            print("###!! model.data?.first?.gender = \(String(describing: model.data?.first?.gender))")
            print("###!! model.data?.first?.birthDate = \(String(describing: model.data?.first?.birthDate))")
            print("###!! model.data?.first?.latestEvent = \(String(describing: model.data?.first?.latestEvent))")
            print("###!! model.data?.first?.petType = \(String(describing: model.data?.first?.petType))")
            print("###!! model.data?.first?.proflie = \(String(describing: model.data?.first?.proflie))")
            print("###!! model.data?.first?.id = \(String(describing: model.data?.first?.id))")
 

        } failureCompletion: { error in
            
            print("###!! error.errorCode = \(error.errorCode))")
            print("###!! error.errorDesc = \(error.errorDesc))")
        }
    }
    
    func getAllPetsTypes(){
        
        let getAllPetsUseCase: GetAllPetsTypesUseCaseProtocol = GetAllPetsTypesUseCase()
        getAllPetsUseCase.getAllPetsTypes { model in
            
            print("###!! model.message = \(String(describing: model.message))")
            print("###!! model.statusCode = \(String(describing: model.statusCode))")
            print("###!! model.data = \(String(describing: model.data))")

            print("###!! model.data?.count = \(String(describing: model.data?.count))")
            print("###!! model.data?.type = \(String(describing: model.data?.first?.type))")
            print("###!! model.data?.id = \(String(describing: model.data?.first?.id))")

        } failureCompletion: { error in
            
            print("###!! error.errorCode = \(error.errorCode))")
            print("###!! error.errorDesc = \(error.errorDesc))")
        }
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
