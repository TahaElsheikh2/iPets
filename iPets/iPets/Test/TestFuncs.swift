//
//  TestFuncs.swift
//  iPets
//
//  Created by Taha on 24/08/2023.
//

import Foundation
import UIKit
import Alamofire
struct TestFuncs{}

//MARK: HeavyTask
extension TestFuncs{
    
    func heavyOperation(button:UIButton) {
        let operation = OperationQueue()
        
        self.enablePrimeButton(button:button, isEnabled: false)
        
        let backgroundOperation = BlockOperation{
            for number in 0...1000_000{
                let isPrime = self.countPrimeNumbers(number: number)
                
                print("\(number) = \(isPrime)")
            }
            OperationQueue.main.addOperation {
                self.enablePrimeButton(button:button, isEnabled: true)
            }
        }
        
        operation.addOperation(backgroundOperation)
    }
    
    func enablePrimeButton(button:UIButton,isEnabled:Bool) {
        
        button.isEnabled = isEnabled
    }
    
    func countPrimeNumbers(number:Int) -> Bool {
        
        if number <= 1 {
            return false
        }
        if number <= 3 {
            return true
        }
        var i = 2
        
        while i*i <= number{
            
            if number % i == 0{
                return false
            }
            i = i + 2
        }
        return true
    }
    
}

//MARK: sample DataTask
extension TestFuncs{
    
    func sampleDataTask() {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.allowsCellularAccess = true
        let session = URLSession(configuration: sessionConfig)
        let urlRequest = URL(string: "http://18.234.38.208:8000/api/user/profile")!
        var request =  URLRequest(url: urlRequest)
        request.httpMethod = "Get"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2ZkOGIxODk5OGQ1MjY3ZGUxMmM1OGQ3MmI1YWY0MGEyOTBiMWZlOGFjMTlmN2U5YWZhYmIwMWE1YmY2NGNhMjA0MmE4MDUyNTYwNjNkMTAiLCJpYXQiOjE2OTMwNzg5NzkuMjc0ODI3LCJuYmYiOjE2OTMwNzg5NzkuMjc0ODMsImV4cCI6MTcyNDcwMTM3OS4yNjkyOTgsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.ntQtNxtI3qWR7l3Ixr5087xWypyQ1y4OvLSTpFnDsoc9Y1Ky4noAwZFnMG_vVbvS8ALKdFHnsZVK6UR8i3y2TapE1yFfEnCEJpb-aKkggd6pWoXDQ1LHIvG8TFafXX7orQIGMQdCVA97coApurExV61Haz3g1LWxJ4wYtuZkbBbVmEBIIcftfkhmJdX9KGsVN0ofZ9Usm112fobGXCDJdRZgEUcPG-754VfjV0Z1GkJXgTWSqhlwLa_03k1SVLV23dWt4NrSxx2eEyRjr2kxo0uksMoOuSmX47tsPbb8wqHvO3kmSaE9ecRSMhmrxJbx4c1MZzPMC3qzJWThIYkckiASDolNDbDC03law0kyxmJ47k-rghoh08_Kli9cixm91CUNb84kTqsNNEgIDD_hRRAxdzUsqlV-ux6a7648d4OL8EiPRQsl4EI7FAaKnu-FE00kqxQZWfD5VQcwJBd31UJVxSx_WecuEmpnbgeIoeveXEYpM2T_xRYsi7PJCLl6f8_kWTKBKU5QBSaWL8EvpD9YGCY006_HSCaQscCbW70y2vlJda7DhbaQb8aMBu5vfRmSR5bDl2Vly6rMxtqWiX7CJo_EVzlCsC-Jwh5aNvbJkm8LDoNsC3mYIJESP1WYdJXXTwi-MCsKz0Q-jdIzHx_I7R8_j4qhjQIp_S72opU", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, response, error in
            print("### data = \(data)")
            print("### response = \(response)")
            print("### error = \(error)")
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("error occurred \(error.debugDescription)")
                return
            }
            guard let data = data else {
                print("data not found \(error.debugDescription)")
                return
            }
            
            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String?
            print("### dataString = \(dataString)")
            
        }
        task.resume()
         
    }
    
    func makeGetRequest() {
        let url = "http://18.234.38.208:8000/api/user/profile"
        
        // Replace this with your JSON payload
        let parameters: [String: String] = [
            "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTFiYTVkYTYxODg0ZDhkMGM4ZjJlZDRmMzFjMjA3ZjI4NWRiYTJhZTBlMWNlNzkyMGQ2MTE1NGVmNDgyMWZkNDlkN2FkNzYyNzk0YzEzZDQiLCJpYXQiOjE2OTMwNzk5MzcuNzU4NjkyLCJuYmYiOjE2OTMwNzk5MzcuNzU4Njk0LCJleHAiOjE3MjQ3MDIzMzcuNzUwNzIxLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.e2j3EFaI7h_8KGBFaBw8EF2JQ9WWLmk8UBpNlhteAjVVQIMqxIaQaYBqSjsG6KnJOZqoN-bPSAgOp-uGuBJbqeTT9qoUukRdUmrCXOzC05e43dqUiK0JQMMaQjq4QFv6ThHsvM88TTLQ6EndzfpYi2B72G3IVrWzbO2i19JoCnnpP6iDdDjNEw0k-DGHK5y93ar5mf3Z5Dap88q6eL1KyjKbPefnAlxSiPOBVm5FWHGoNAcbJ9O0RpAkXQ0dmNLovGlaF6wI6ex8EO_B1WTm5bNWJ4Mq6RYhtm5d6s6Imb5W9ZUI91IsLlFQgJOhDkdP0XEgl6oVyXRDMIJgZUjEDQWjN3flb5UZ7cLqIHnrwPVxxMUX5su5fNTxv9ZYd0C8AtWaB7Yz0OxmNSIMtEkGunHEC2wflCZWgX_7gtKfNEJ8DAM4FmesZV7Kdn0BQxQI20AkN19e-WiPRGxuNGBeZ3STjiL-bGG9coHgeoigXq9iUCWB0nkxf4notADxzBEBRa2hLMuZOqjL3mbEYgEy-cC1wvi1zcfwtbY3YAMGXqHwN6_hM1R5hU8x_5KBRfRYCcIcluO9xYYEJCpxPn0Y5qQO3uIGultwR0JXU4qIFu_FdCDFmzA5xkKEhJwOAskGT_9J35_p0H0bXGu2Autuo0FNDSsG-2kV5aKA0vDQ3EY",
            "Accept": "application/json"
        ]
        
//        let request = AF.request("https://swapi.dev/api/films")

        var headers = HTTPHeaders(parameters)
        
        AF.request(url, method: .get ,encoding: JSONEncoding.default,headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Response JSON: \(value)")
                    // Handle your success response here
                    
                case .failure(let error):
                    print("Error: \(error)")
                    // Handle your error here
                }
            }
    }
}

//MARK: sample for Post request
extension TestFuncs{
    
    func sampleForPostRequest(){
        
//        let json = "{ 'email' : 'halaabdulmottleb@gmail.com', 'password':'12345678'}"
        let url = URL(string: "http://18.234.38.208:8000/api/auth/login")!//http://18.234.38.208:8000

        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = self.body()
        let session = URLSession.shared
        let task = session.dataTask(with: request){ data, response, error in
            
            if let data = data{
                let jsonData = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print("### json data = \(String(describing: jsonData))")
            }else{
                print("### error = \(error.debugDescription  )")
            }
        }
        
        task.resume()
        
    }
    func body()  -> Data? {
        let bodyData = ["email":"halaabdulmottleb@gmail.com","password":"12345678"]
        var data: Data?
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(bodyData) {
            data = jsonData
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print("####$ jsonString = \(jsonString)")
//            }
        }

        return data
    }
    
    func makePostRequest() {
        
        var request = RegisterRequest.Register
        

        AF.request(request).validate().responseDecodable(of: AuthModel.self) { (response) in
            print("#### response = \(response)")

          if let value = response.value {
              print("#### value.data?.email = \(value.data?.email)")

          }
          // 6
        }
        
//        let url = "http://18.234.38.208:8000/api/auth/login"
//
//        // Replace this with your JSON payload
//        let parameters: [String: Any] = [
//            "email": "halaabdulmottleb@gmail.com",
//            "password": "12345678"
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    print("Response JSON: \(value)")
//                    // Handle your success response here
//
//                case .failure(let error):
//                    print("Error: \(error)")
//                    // Handle your error here
//                }
//            }
    }
}

//MARK: sample upload Image
extension TestFuncs{
    
    func sampleUploadImage(){
        
        let image = UIImage(named: "Test")
        let imageData = image?.jpegData(compressionQuality: 1.0)
        let url = URL(string: "http://127.0.0.1:5000/upload")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "Post"
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: SessionDelegate(), delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: urlRequest, from: imageData){data, response, error in
            
            print("### data = \(data)")
            print("### response = \(response)")
            print("### error = \(error)")
            
            guard let data = data else{
                print("### data is nil")
                return
            }
            let jsonData = String(data: data, encoding: .utf8)
            print("###$$ jsonData = \(jsonData)")
        }
        
        task.resume()
        
    }
}

//MARK: Sample Download
extension TestFuncs{
    
    
    func sampleDownload(successResult: @escaping (Data?) -> Void) {
        
        let url = URL(string: "https://live.staticflickr.com/221/464553110_0c6709fb4b.jpg")!
        
        let requestURL = URLRequest(url: url)
        
        let task = URLSession.shared.downloadTask(with: requestURL) { url, response, error in
            
            print("### url = \(url)")
            print("### response = \(response)")
            print("### error = \(error)")
            
            guard let location = url else{
                print("### url = nil")
                return
            }
            var imageData = self.getImageData(url: location)
            successResult(imageData)
        }
        task.resume()
    }
    
    func getImageData(url:URL) -> Data? {
        var imageData : Data?
        
        do {
            try imageData = Data(contentsOf: url)

        } catch {
            
        }
        return imageData
        
    }
}
class SessionDelegate: NSObject,URLSessionDataDelegate{
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        print("###$ bytesSent = \(bytesSent) %")
        print("###$ totalBytesSent = \(totalBytesSent) %")
        print("###$ totalBytesExpectedToSend = \(totalBytesExpectedToSend) %")

        let progress = round(Float(totalBytesSent)/Float(totalBytesExpectedToSend) * 100)
        print("###$progress = \(progress) %")
    }
    
}
import Foundation

// MARK: - Profile
struct Profile: Codable {
    var data: DataClass?
    var message, messageCode: String?
    var statusCode: Int?

    enum CodingKeys: String, CodingKey {
        case data, message
        case messageCode = "message_code"
        case statusCode = "status_code"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    var email: String?
    var id: Int?
    var latitude: String?
    var location: Location?
    var longitude: String?
    var pets, petsByType: [String]?
    var petsCount: Int?
    var phone1, phone2, profileImage, type: String?
    var upcomingEvents: [String]?
    var userName: String?

    enum CodingKeys: String, CodingKey {
        case email, id, latitude, location, longitude, pets
        case petsByType = "pets_by_type"
        case petsCount = "pets_count"
        case phone1 = "phone_1"
        case phone2 = "phone_2"
        case profileImage = "profile_image"
        case type
        case upcomingEvents = "upcoming_events"
        case userName = "user_name"
    }
}

// MARK: - Location
struct Location: Codable {
    var address, apartment, building, floor: String?
    var id: Int?
    var latitude, longitude: String?
}
