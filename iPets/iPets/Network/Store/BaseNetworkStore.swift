//
//  BaseNetworkStore.swift
//  iPets
//
//  Created by Taha on 22/08/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseNetworkStore<T: Codable>{
    
    func requestWith(request:ApiRequest, responseHandler: @escaping (T) -> Void)  {
       
        AF.request(request).validate().responseDecodable(of: AuthModel.self) { (response) in
            print("#### response = \(response)")

          if let value = response.value {
              print("#### value.data?.email = \(value.data?.email)")
              responseHandler(value as! T)
          }else{
//              responseHandler(ApiResponse(success: false))

          }
        }
    }
    
    
    func callApi(request: ApiRequest, responseHandler: @escaping (ApiResponse<T>) -> Void) {

        let urlRequest = urlRequestWith(apiRequest: request)
        AF.request(urlRequest).responseData { (response) in
            switch(response.result) {
            case .success:
                let apiResponse = self.successResponse(request: request, response: response)
                responseHandler(apiResponse)
            case .failure:
                self.failureResponse(response: response)
            }
        }
    }
    
    func urlRequestWith(apiRequest: ApiRequest) -> URLRequest {
        let  completeUrl = apiRequest.baseURL + apiRequest.path

        var urlRequest = URLRequest(url: URL(string: completeUrl)!)
        urlRequest.httpMethod = apiRequest.method.rawValue
        self.addHttpHeader(request: &urlRequest, apiRequest: apiRequest)
        self.addRequestBody(request: &urlRequest, apiRequest: apiRequest)
        return urlRequest
    }

    func addRequestBody(request:inout URLRequest, apiRequest:ApiRequest) {
        
        var body : Data?
        
        do {
            body = try apiRequest.body()
        }catch{}
        
        switch apiRequest.method{
        case .patch,.post,.put:
            request.httpBody = body
        default:
            break;
        }
    }
    
    func addHttpHeader(request:inout URLRequest, apiRequest:ApiRequest) {
    
        guard let headers = apiRequest.headers else { return }
        for header in headers{
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
    }
    
    // here we are going to parse the data
    func successResponse(request: ApiRequest,
                                     response: AFDataResponse<Data>) -> ApiResponse<T>{
        do {
            // Step 1
            let responseJson = try JSON(data: response.data!)
            // Step 2
            let dataJson = responseJson["data"].object
            let data = try JSONSerialization.data(withJSONObject: dataJson,
                                                  options: [])
            // Step 3
            let decodedValue = try JSONDecoder().decode(T.self, from: data)
            print("successResponse dataJson= \(dataJson)")

            return ApiResponse(success: true, data: decodedValue)

        } catch {
            return ApiResponse(success: false)
        }
    }

    func failureResponse(response: AFDataResponse<Data>) {
        // do something here
    }

}
class ApiResponse<T:Codable> {
    var success: Bool!   // whether the API call passed or failed
    var message: String? // message returned from the API
    var data: T? // actual data returned from the API

    init(success: Bool, message: String? = nil, data: T? = nil) {
        self.success = success
        self.message = message
        self.data = data
    }
}
