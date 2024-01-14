//
//  KeychainService.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import Foundation
import Security

protocol KeychainServiceProtocol {
    func setValue(service: String, account: String, value: Data) -> Bool
    func getValue(service: String, account: String) -> Data?
}

final class KeychainService: KeychainServiceProtocol {
    
    func setValue(service: String, account: String, value: Data) -> Bool {
        let query: [String: Any] = [
            toString(kSecClass): kSecClassGenericPassword,
            toString(kSecAttrAccount): account,
            toString(kSecAttrService): service,
            toString(kSecValueData): value
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == noErr {
            return true
        } else if status == errSecDuplicateItem {
            return updateValue(service: service, account: account, value: value)
        } else {
            return false
        }
    }
    func getValue(service: String, account: String) -> Data? {
        let query: [String: Any] = [
            toString(kSecClass): kSecClassGenericPassword,
            toString(kSecAttrAccount): account,
            toString(kSecAttrService): service,
            toString(kSecReturnData): true
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(
                query as CFDictionary,
                &result
        )
        guard status == noErr, let data = result as? Data else {return nil}
        return data
    }
    
    private func updateValue(service: String, account: String, value: Data) -> Bool {
        let updateQuery: [String: Any] = [
            toString(kSecClass): kSecClassGenericPassword,
            toString(kSecAttrAccount): account,
            toString(kSecAttrService): service
        ]

        let updateAttributes: [String: Any] = [
            toString(kSecValueData): value
        ]

        let updateStatus = SecItemUpdate(updateQuery as CFDictionary, updateAttributes as CFDictionary)

        return updateStatus == noErr
    }
}

private func toString(_ value: CFString) -> String {
    return value as String
}
