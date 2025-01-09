//
//  AviWXStorage.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//


import Foundation

extension UserDefaults: AviWXStorage {
    enum Constants {
        static let icaoIdsKey = "icaoIdsKey"
    }
    
    public func save(_ icaoId: String) -> Bool {
        var icaoIds = retrieve()
        guard !icaoIds.contains(icaoId) else { return false }
        icaoIds.insert(icaoId, at: 0)
        set(icaoIds, forKey: Constants.icaoIdsKey)
        return true
    }
    
    public func delete(_ icaoId: String) -> Bool {
        var icaoIds = retrieve()
        guard let index = icaoIds.firstIndex(of: icaoId) else { return false }
        icaoIds.remove(at: index)
        set(icaoIds, forKey: Constants.icaoIdsKey)
        return true
    }
    
    public func exists(_ icaoId: String) -> Bool {
        let icaoIds = retrieve()
        return icaoIds.contains(icaoId)
    }
    
    public func retrieve() -> [String] {
        return array(forKey: Constants.icaoIdsKey) as? [String] ?? []
    }
}
