//
//  MainModulesHelper.swift
//  iPets
//
//  Created by Taha on 10/08/2023.
//

import Foundation
enum AppModules {
    case app
    case auth
    case home
    case cart
    case non

}
class MainModulesHelper {
    static let shared = MainModulesHelper()
    
    private init() {}
    
    func getModules(key: String) -> AppModules {
        switch key {
        case "splash":
            return .app
        case "login","TestViewController":
            return .auth
        case "register":
            return .auth
        case "home":
            return .home
        case "cart":
            return .cart
        default:
            return .non
        }
    }
    
}
