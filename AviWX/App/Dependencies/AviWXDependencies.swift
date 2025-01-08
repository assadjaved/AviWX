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
    let storage: AviWXStorage = UserDefaults.standard
    let networking: AviWXNetworkingType = AviWXNetworking.shared
}
