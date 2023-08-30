//
//  KeyChainHelper.swift
//  ContinueAPI
//
//  Created by Kurumsal on 17.08.2023.
//

import Foundation

final class KeyChainHelper {
    static let shared = KeyChainHelper()
    
    init(){ }
    
    func saveKey(_ data:Data, service: String, account: String) {
        let query = [
            kSecValueData:data,
            kSecAttrService:service,
            kSecAttrAccount:account,
            kSecClass: kSecClassGenericPassword] as [CFString : Any] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            
            let query = [
                kSecAttrService:service,
                kSecAttrAccount:account,
                kSecClass: kSecClassGenericPassword
            ] as [CFString : Any] as CFDictionary
            
            let updateAttr = [kSecValueData: data] as CFDictionary
            
            SecItemUpdate(query, updateAttr)
        }
    }
    
    func readKey(service: String, account: String)-> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as [CFString : Any] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return result as? Data
    }
    
    
}
