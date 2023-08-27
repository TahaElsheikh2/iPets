//
//  CacheHandler.swift
//  iPets
//
//  Created by Taha on 27/08/2023.
//

import Foundation
struct CacheHandler {
    
    static func saveStringToKeychain(value: String, forKey key: String) {
        guard let valueData = value.data(using: .utf8) else {
            print("error while saving \(key) CacheHandler->saveStringToKeychain->valueData is nil")
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: valueData,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess{
            print("error while saving \(key) CacheHandler status is false")
        }
    }

    static func isSaveStringToKeychain(value: String, forKey key: String) -> Bool {
        guard let valueData = value.data(using: .utf8) else {
            return false
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: valueData,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    static func getStringFromKeychain(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data, let value = String(data: data, encoding: .utf8) {
            return value
        } else {
            return nil
        }
    }

}
