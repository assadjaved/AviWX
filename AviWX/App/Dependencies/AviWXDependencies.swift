//
//  Dependencies.swift
//  AviWX
//
//  Created by Asad Javed on 08/01/2025.
//


import AviWXStorage
import AviWXNetworking

protocol AviWXDependencies {
    var storage: AviWXStorage { get }
    var networking: AviWXNetworkingType { get }
}

class AppDependencies: AviWXDependencies {
    let storage: AviWXStorage
    let networking: AviWXNetworkingType
    
    init(
        storage: AviWXStorage = FileManager.default,
        networking: AviWXNetworkingType = AviWXNetworking.shared
    ) {
        self.storage = storage
        self.networking = networking
    }
}
