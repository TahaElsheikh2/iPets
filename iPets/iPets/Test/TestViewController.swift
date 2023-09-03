//
//  TestViewController.swift
//  iPets
//
//  Created by Taha on 23/08/2023.
//

import UIKit
import Combine
class TestViewController: UIViewController {
    weak var coordinator: AuthCoordinator?

    var testFunc = TestFuncs()
    
    @IBOutlet weak var countPrimeNumberButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var authUseCase = AuthUseCase()
    private var cancellableSet: Set<AnyCancellable> = []

    @IBAction func countPrimeNumber(_ sender: Any) {
      
        self.checkToken()
        print("--------------------------------------------------------------- \n")
        self.getAllPetsTypes()
//        self.authUseCase.reAuth().sink(receiveCompletion: {result in
//            print("result = \(result)")
//        }, receiveValue: {model in
//            print("authUseCase model = \(model)")
//
//        }).store(in: &cancellableSet)
    }
    
    func tets() {
        
        var loader = "".publisher

        _ = loader.sink(receiveCompletion: { completion in
            
            switch completion{
            case .finished:
                print("")
            case .failure(let error):
                print("error = \(error)")
            }
        }, receiveValue: { value in
            print(" value = \(value)")
        })
//        loader = "taha"
//        loader = "mohamed"
        let fibonacciPublisher = [0,1,1,2,3,5].publisher
        _ = fibonacciPublisher.sink(receiveCompletion: { completion in
            switch completion {
                case .finished:
                    print("finished")
                case .failure(let never):
                    print(never)
            }
        }, receiveValue: { value in
            print(value)
        })
    }

    func checkToken() {
    
        
        print("###!! checkToken TokenManager().getCachedToken() = \(TokenManager().getCachedToken()))")
        print("###!! checkToken TokenManager().isValidToken() = \(TokenManager().isValidToken()))")
        print("###!! checkToken CacheManager().Email_Constant() = \(CacheHandler.getStringFromKeychain(forKey: CacheConstants.Email_Constant)))")
        print("###!! checkToken CacheManager().Password_Constant() = \(CacheHandler.getStringFromKeychain(forKey: CacheConstants.Password_Constant)))")

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
    let getAllPetsUseCase: GetAllPetsTypesUseCaseProtocol = GetAllPetsTypesUseCase()

    func getAllPetsTypes(){
        
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
