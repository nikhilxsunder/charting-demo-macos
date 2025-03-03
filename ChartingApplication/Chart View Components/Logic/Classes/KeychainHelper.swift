//
//  KeychainHelper.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/14/25.
//

import Foundation
import Security

// Keychain Helper
class KeychainHelper
{
    static let shared = KeychainHelper()
    // Save
    func save(_ key: String, value: String)
    {
        guard let data = value.data(using: .utf8) else
        {
            return
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    // Get
    func get(_ key: String) -> String?
    {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr,
           let data = dataTypeRef as? Data,
           let value = String(data: data, encoding: .utf8)
        {
            return value
        }
        return nil
    }
    // Delete
    func delete(_ key: String)
    {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
