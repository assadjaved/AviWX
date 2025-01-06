//
//  AviWXStorage.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//


import Foundation

protocol AviWXStorage {
    func save(_ icaoId: IcaoId)
    func delete(_ icaoId: IcaoId)
    func exists(_ icaoId: IcaoId) -> Bool
    func retrieve() -> [IcaoId]
}

extension UserDefaults: AviWXStorage {
    enum Constants {
        static let icaoIdsKey = "icaoIdsKey"
    }
    
    func save(_ icaoId: IcaoId) {
        var icaoIds = retrieve()
        guard !icaoIds.contains(icaoId) else { return }
        icaoIds.insert(icaoId.lowercased(), at: 0)
        set(icaoIds, forKey: Constants.icaoIdsKey)
    }
    
    func delete(_ icaoId: IcaoId) {
        var icaoIds = retrieve()
        guard let index = icaoIds.firstIndex(of: icaoId.lowercased()) else { return }
        icaoIds.remove(at: index)
        set(icaoIds, forKey: Constants.icaoIdsKey)
    }
    
    func exists(_ icaoId: IcaoId) -> Bool {
        let icaoIds = retrieve()
        return icaoIds.contains(icaoId.lowercased())
    }
    
    func retrieve() -> [IcaoId] {
        return array(forKey: Constants.icaoIdsKey) as? [String] ?? []
    }
}
