//
//  AviWXStorage+FileManager.swift
//  Pods
//
//  Created by Asad Javed on 09/01/2025.
//


struct Metars: Codable {
    let icaoIds: [String]
}

extension FileManager: AviWXStorage {
    enum Constants {
        static let metarsFile = "metars.json"
    }
    
    enum Action {
        case save
        case delete
        
        var error: AviWXStorageError {
            switch self {
            case .save:
                return .failedToSaveMetar
            case .delete:
                return .failedToDeleteMetar
            }
        }
    }
    
    var fileUrl: URL? {
        guard let documentDirectory = self.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentDirectory.appendingPathComponent(Constants.metarsFile)
    }
    
    public func save(_ icaoId: String) throws {
        var icaoIds = retrieve()
        guard !icaoIds.contains(icaoId) else {
            throw AviWXStorageError.metarAlreadyExists
        }
        icaoIds.insert(icaoId, at: 0)
        try saveToDisk(icaoIds, action: .save)
    }
    
    public func delete(_ icaoId: String) throws {
        var icaoIds = retrieve()
        guard let index = icaoIds.firstIndex(of: icaoId) else {
            throw AviWXStorageError.metarNotFound
        }
        icaoIds.remove(at: index)
        try saveToDisk(icaoIds, action: .delete)
    }
    
    public func exists(_ icaoId: String) -> Bool {
        let icaoIds = retrieve()
        return icaoIds.contains(icaoId)
    }
    
    public func retrieve() -> [String] {
        guard let fileUrl else {
            return []
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let metars = try JSONDecoder().decode(Metars.self, from: data)
            return metars.icaoIds
        } catch {
            return []
        }
    }
    
    private func saveToDisk(_ icaoIds: [String], action: Action) throws {
        guard let fileUrl else {
            throw AviWXStorageError.metarsResourceNotFound
        }
        let metars = Metars(icaoIds: icaoIds)
        do {
            let data = try JSONEncoder().encode(metars)
            try data.write(to: fileUrl, options: .atomic)
        } catch {
            throw action.error
        }
    }
}
