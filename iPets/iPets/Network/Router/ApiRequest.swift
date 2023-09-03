//
//  ApiRequest.swift
//  iPets
//
//  Created by Taha on 22/08/2023.
//

import Foundation
import Alamofire

protocol ApiRequest :URLRequestConvertible{
    var baseURL:String {get}
    var path: String {get}
    var headers: [String:String]? {get}
    var parameters: [String:Any]? {get}
    var shouldAuth : Bool {get}
    var method: HTTPMethod { get }
    var token: TokenManagerProtocol {get}
    func body() throws -> Data?

}

extension ApiRequest{

    
    var baseURL:String {
        #if DEBUG
        return "http://18.234.38.208:8000"
        #else
        return "http://18.234.38.208:8000"
        #endif
    }

    var path : String {
        return ""
    }
    
    var headers: [String:String]? {
        return ["Accept":"application/json"]//,"Host":"18.234.38.208:8000","Cache-Control":"no-cache, private","Transfer-Encoding":"chunked","Connection":"keep-alive"]
    }
    
    var parameters: [String:Any]? {
        return [:]
    }

    var method: HTTPMethod {
        return .get
    }
    
    var isAuth: Bool {
        return false
    }
    
    var shouldAuth: Bool {
        return true
    }
    
    func body() throws -> Data? {
        
        return nil
    }
    
    var token: TokenManagerProtocol {
        
        return TokenManager()
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURL)!

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.method = method
        urlRequest.headers = HTTPHeaders(self.headers ?? [:])
       
        if shouldAuth {
            print("didEnter asURLRequest shouldAuth self.token.getCachedToken() = \(self.token.getCachedToken())")
            urlRequest.setValue("Bearer \(self.token.getCachedToken())",
            forHTTPHeaderField: "Authorization")
        }
        print("didEnter asURLRequest Func")
        
        switch method {
        case .post,.patch,.put:
            if let param = parameters {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
            }

            if let headers = headers {
                urlRequest.headers = HTTPHeaders(headers)
            }

            if let body = try body() {
                urlRequest.httpBody = body
            }

        case .get:
            if let param = parameters {
               urlRequest =  try URLEncoding.default.encode(urlRequest, with: param)
            }

            if let headers = headers {
                urlRequest.headers = HTTPHeaders(headers)
            }

        case .delete:
            if let param = parameters {
               urlRequest =  try URLEncoding.default.encode(urlRequest, with: param)
            }

            if let headers = headers {
                urlRequest.headers = HTTPHeaders(headers)
            }
        default:
            return urlRequest
        }
        return urlRequest
    }
}


//extension ApiBaseRouter {
//    var isAuth: Bool {
//        return false
//    }
//    
//    var shouldAuth: Bool {
//        return true
//    }
//
//
//    var baseUrl: String? {
//        return nil
//    }
//    
//    var method: HTTPMethod {
//        return .get
//    }
//    
//    var parameters: [String:Any]? {
//        return [:]
//    }
//    
//    var headers: [String:String]? {
//        return [:]
//    }
//    
//    func body() throws -> Data? {
//        return nil
//    }
//}
