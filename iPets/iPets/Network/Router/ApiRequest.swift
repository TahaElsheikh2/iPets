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
    var method: HTTPMethod { get }
    func body() throws -> Data?
}

extension ApiRequest{
    var baseURL:String {
        #if DEBUG
        return "https://run.mocky.io/"
        #else
        return "https://run.mocky.io/"
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
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURL)!

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.method = method
        urlRequest.headers = HTTPHeaders(self.headers ?? [:])

        switch method {
        case .post,.patch,.put:
            if var param = parameters {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
            }

            if var headers = headers {
                urlRequest.headers = HTTPHeaders(headers)
            }

            if let body = try body() {
                urlRequest.httpBody = body
            }

        case .get:
            if var param = parameters {
               urlRequest =  try URLEncoding.default.encode(urlRequest, with: param)
            }

            if var headers = headers {
                urlRequest.headers = HTTPHeaders(headers)
            }

        case .delete:
            if var param = parameters {
               urlRequest =  try URLEncoding.default.encode(urlRequest, with: param)
            }

            if var headers = headers {
                urlRequest.headers = HTTPHeaders(headers)
            }
        default:
            return urlRequest
        }
        return urlRequest
    }
}
//
//public enum HTTPMethod: String {
//    case options = "OPTIONS"
//    case get     = "GET"
//    case head    = "HEAD"
//    case post    = "POST"
//    case put     = "PUT"
//    case patch   = "PATCH"
//    case delete  = "DELETE"
//    case trace   = "TRACE"
//    case connect = "CONNECT"
//}


public protocol ApiBaseRouter  {
    var isAuth: Bool { get }
    var shouldAuth: Bool { get }
    var baseUrl: String? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String:String]? { get }
    var parameters: [String:Any]? { get }
    func body() throws -> Data?
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
