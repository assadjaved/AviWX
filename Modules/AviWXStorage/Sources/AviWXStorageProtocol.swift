//
//  AviWXStorage.swift
//  Pods
//
//  Created by Asad Javed on 07/01/2025.
//


public protocol AviWXStorage {
    func save(_ icaoId: String) throws
    func delete(_ icaoId: String) throws
    func exists(_ icaoId: String) -> Bool
    func retrieve() -> [String]
}
