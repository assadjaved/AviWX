//
//  AviWXStorage.swift
//  Pods
//
//  Created by Asad Javed on 07/01/2025.
//


public protocol AviWXStorage {
    func save(_ icaoId: String)
    func delete(_ icaoId: String)
    func exists(_ icaoId: String) -> Bool
    func retrieve() -> [String]
}
