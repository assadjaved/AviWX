//
//  AviWXStorage.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//


import Foundation

protocol AviWXStorage {
    func save(_ icaoIds: [String])
    func retrieve() -> [String]
}

extension UserDefaults: AviWXStorage {
    enum Constants {
        static let icaoIdsKey = "icaoIdsKey"
    }
    
    func save(_ icaoIds: [String]) {
        set(icaoIds, forKey: Constants.icaoIdsKey)
    }
    
    func retrieve() -> [String] {
        return array(forKey: Constants.icaoIdsKey) as? [String] ?? []
    }
}
