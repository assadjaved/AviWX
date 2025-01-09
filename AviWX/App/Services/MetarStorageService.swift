//
//  MetarStorageService.swift
//  AviWX
//
//  Created by Asad Javed on 07/01/2025.
//

import AviWXStorage

class MetarStorageService {
    private let storage: AviWXStorage
    
    init(storage: AviWXStorage) {
        self.storage = storage
    }
    
    func save(_ icaoId: String) -> Bool {
        storage.save(icaoId)
    }
    
    func delete(_ icaoId: String) -> Bool {
        storage.delete(icaoId)
    }
    
    func exists(_ icaoId: String) -> Bool {
        storage.exists(icaoId)
    }
    
    func retrieve() -> [String] {
        storage.retrieve()
    }
}
