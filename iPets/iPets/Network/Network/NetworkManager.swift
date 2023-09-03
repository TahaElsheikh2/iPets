//
//  NetworkManager.swift
//  iPets
//
//  Created by Taha on 22/08/2023.
//

import Foundation
import Alamofire
import SwiftyJSON
import Combine
class NetworkManager<T: Codable>{

    lazy var authUseCase : AuthUseCaseProtocol = AuthUseCase()
    var cancellables = Set<AnyCancellable>()

//MARK: - AF Networking with Combine
    func callApi(request:ApiRequest) -> AnyPublisher<T?,IPETSErrors> {

        if request.shouldAuth{
            return performRequestWithAuth(request: request)
        }else{
            return performRequest(request: request)
        }
    }
    
    func performRequest(request:ApiRequest) -> AnyPublisher<T?,IPETSErrors> {
        return Future<T?, IPETSErrors> { promise in
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T?.self) { response in
                    print("## [Request] : \(String(describing: response.request))")
                    print("## [Response] : \(response.debugDescription)")
                    switch response.result {
                    case .success(let model):
                        promise(.success(model))
                    case .failure(let error):
                        if response.response?.statusCode == 200{
                            promise(.success(nil))
                        }else{
                            promise(.failure(.networkError(error)))
                        }
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    private func performRequestWithAuth(request:ApiRequest) -> AnyPublisher<T?,IPETSErrors> {
        
        if TokenManager().isValidToken(){
            return self.performRequest(request: request)
        }else{
            return self.reAuth()
                .print("reAuth print :")
                .handleEvents(
                receiveSubscription: { _ in print("reAuth handleEvents :") },
                receiveCompletion: {
                  guard case .failure(let error) = $0 else { return }
                  print("reAuth Got error: \(error)")
                }
              )
                .flatMap{ _ in self.performRequest(request: request) }
                .eraseToAnyPublisher()
        }
    }
    
    private func reAuth() -> AnyPublisher<AuthModelDTO?,IPETSErrors>
    {
        return self.authUseCase.reAuth()
    }
}

struct CustomError{
    var errorCode = Int(0)
    var errorDesc = ""
}

enum IPETSErrors: Error{
    case urlError
    case responseError
    case networkError(AFError)
    case decoderError
    case unknownError
    case mappingErrorToNetworkError
    case nilModel
    case otherError(String)

}

extension IPETSErrors{
    
    var localizedDescription:String{
        switch self{
        case .urlError:
            return "#urlError"
        case .responseError:
            return "#responseError"
        case .networkError(let error):
            return "#networkError = \(self.getLocalizedDescription(error: error))"
        case .decoderError:
            return "#decoderError"
        case .nilModel:
            return "#model is Nil"
        case .mappingErrorToNetworkError:
            return "#mappingErrorToNetworkError"
        case .otherError(let error):
            return "#otherError = \(error)"
        case .unknownError:
            return "#unknownError"
        }
    }
    
    func getLocalizedDescription(error:AFError) -> String {
        
        switch error.responseCode{
        case 422:
            return "email or password error"
        default:
            return "something went wrong \(error.localizedDescription)"
        }
    }
}

//MARK: Legacy
//extension NetworkManager{
//
//    //MARK: - AF Networking without Combine
//    //    internal func requestWith(request:ApiRequest, successCompletion: @escaping (T) -> Void,failureResponse: @escaping (CustomError) -> Void)  {
//    //
//    //        if request.shouldAuth{
//    //            self.requestWithAuth(request: request,
//    //                                 successCompletion: successCompletion,
//    //                                 failureResponse: failureResponse)
//    //        }else{
//    //            self.performRequest(request: request,
//    //                                 successCompletion: successCompletion,
//    //                                 failureResponse: failureResponse)
//    //        }
//    //    }
//    //
//    //    private func requestWithAuth(request:ApiRequest, successCompletion: @escaping (T) -> Void,failureResponse: @escaping (CustomError) -> Void)  {
//    //
//    //        if TokenManager().isValidToken(){
//    //            self.performRequest(request: request, successCompletion: successCompletion, failureResponse: failureResponse)
//    //        }else{
//    //            authUseCase.legacyReAuth { model in
//    //                self.performRequest(request: request, successCompletion: successCompletion, failureResponse: failureResponse)
//    //            } failureCompletion: { error in
//    //                failureResponse(error)
//    //            }
//    //        }
//    //    }
//    //
//    //    private func performRequest(request:ApiRequest, successCompletion: @escaping (T) -> Void,failureResponse: @escaping (CustomError) -> Void) {
//    //
//    //        AF.request(request).validate().responseDecodable(of: T.self) { (response) in
//    //            print("## [Request] : \(String(describing: response.request))")
//    //            print("## [Response] : \(response.debugDescription)")
//    //
//    //          if let value = response.value {
//    //              successCompletion(value)
//    //          }else{
//    //              var error = CustomError()
//    //              error.errorDesc = response.debugDescription
//    //              error.errorCode = response.error?.responseCode ?? 999
//    //              failureResponse(error)
//    //          }
//    //        }
//    //    }
//
//    //MARK: - ChatGBT Call 2 requests
//    //    @available(iOS 14.0, *)
//    //    func callApi1(request: ApiRequest) -> AnyPublisher<T?, NetworkErrors> {
//    //        if request.shouldAuth {
//    //            // Check if the token is expired, and perform re-authentication if needed
//    //            return checkTokenExpiration()
//    //                .flatMap { tokenExpired -> AnyPublisher<T?, NetworkErrors> in
//    //                    if tokenExpired {
//    //                        return self.reAuth()
//    //                            .flatMap { _ in self.performRequest(request: request) }
//    //                            .eraseToAnyPublisher()
//    //                    } else {
//    //                        return self.performRequest(request: request)
//    //                    }
//    //                }
//    //                .eraseToAnyPublisher()
//    //        } else {
//    //            return callApi(request: request)
//    //        }
//    //    }
//    //
//    //    func checkTokenExpiration() -> AnyPublisher<Bool, Never> {
//    //        // Implement logic to check if the token is expired.
//    //        // You might need to access the token's expiration date or use other criteria.
//    //        // Return true if the token is expired, false otherwise.
//    //        let isTokenExpired = TokenManager().isValidToken()
//    //        return Just(isTokenExpired)
//    //            .eraseToAnyPublisher()
//    //    }
//
//  // MARK: performRequest with combine Alamofire
//    func performRequest(request:ApiRequest) -> AnyPublisher<T?,NetworkErrors>{
//
//        return AF.request(request)
//                     .publishDecodable(type: T?.self)
//                     .value()
//                     .print("AF.request(request)")
//                     .handleEvents(
//                       receiveSubscription: { _ in print("receiveSubscription") },
//                       receiveOutput: { output in
//                           print("receiveOutput : \(String(describing: output))")},
//                       receiveCompletion: {
//                         guard case .failure(let error) = $0 else { return }
//                         print("Got error: \(error)")
//                       }
//                     ).mapError { _ in NetworkErrors.decoderError }
//            .eraseToAnyPublisher()
//    }
//
//    //MARK: - Legacy CallApi Code
//    //    func callApilLegacy(request: ApiRequest, responseHandler: @escaping (ApiResponse<T>) -> Void) {
//    //
//    //        let urlRequest = urlRequestWith(apiRequest: request)
//    //        AF.request(urlRequest).responseData { (response) in
//    //            switch(response.result) {
//    //            case .success:
//    //                let apiResponse = self.successResponse(request: request, response: response)
//    //                responseHandler(apiResponse)
//    //            case .failure:
//    //                self.failureResponse(response: response)
//    //            }
//    //        }
//    //    }
//    //
//    //    func urlRequestWith(apiRequest: ApiRequest) -> URLRequest {
//    //        let  completeUrl = apiRequest.baseURL + apiRequest.path
//    //
//    //        var urlRequest = URLRequest(url: URL(string: completeUrl)!)
//    //        urlRequest.httpMethod = apiRequest.method.rawValue
//    //        self.addHttpHeader(request: &urlRequest, apiRequest: apiRequest)
//    //        self.addRequestBody(request: &urlRequest, apiRequest: apiRequest)
//    //        return urlRequest
//    //    }
//    //
//    //    func addRequestBody(request:inout URLRequest, apiRequest:ApiRequest) {
//    //
//    //        var body : Data?
//    //
//    //        do {
//    //            body = try apiRequest.body()
//    //        }catch{}
//    //
//    //        switch apiRequest.method{
//    //        case .patch,.post,.put:
//    //            request.httpBody = body
//    //        default:
//    //            break;
//    //        }
//    //    }
//    //
//    //    func addHttpHeader(request:inout URLRequest, apiRequest:ApiRequest) {
//    //
//    //        guard let headers = apiRequest.headers else { return }
//    //        for header in headers{
//    //            request.addValue(header.value, forHTTPHeaderField: header.key)
//    //        }
//    //    }
//    //
//    //   //  here we are going to parse the data
//    //    func successResponse(request: ApiRequest,
//    //                                     response: AFDataResponse<Data>) -> ApiResponse<T>{
//    //        do {
//    //            // Step 1
//    //            let responseJson = try JSON(data: response.data!)
//    //            // Step 2
//    //            let dataJson = responseJson["data"].object
//    //            let data = try JSONSerialization.data(withJSONObject: dataJson,
//    //                                                  options: [])
//    //            // Step 3
//    //            let decodedValue = try JSONDecoder().decode(T.self, from: data)
//    //            print("successResponse dataJson= \(dataJson)")
//    //
//    //            return ApiResponse(success: true, data: decodedValue)
//    //
//    //        } catch {
//    //            return ApiResponse(success: false)
//    //        }
//    //    }
//    //
//    //    func failureResponse(response: AFDataResponse<Data>) {
//    //        // do something here
//    //    }
//}
//class ApiResponse<T:Codable> {
//    var success: Bool!   // whether the API call passed or failed
//    var message: String? // message returned from the API
//    var data: T? // actual data returned from the API
//
//    init(success: Bool, message: String? = nil, data: T? = nil) {
//        self.success = success
//        self.message = message
//        self.data = data
//    }
//}


