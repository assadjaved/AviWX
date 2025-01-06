//
//  AviWXStorage.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//


import Foundation

protocol AviWXStorage {
    func save(_ icaoId: String)
    func retrieve() -> [String]
}

extension UserDefaults: AviWXStorage {
    enum Constants {
        static let icaoIdsKey = "icaoIdsKey"
    }
    
    func save(_ icaoId: String) {
        var icaoIds = retrieve()
        guard !icaoIds.contains(icaoId) else { return }
        icaoIds.append(icaoId)
        set(icaoIds, forKey: Constants.icaoIdsKey)
    }
    
    func retrieve() -> [String] {
        return array(forKey: Constants.icaoIdsKey) as? [String] ?? []
    }
}
