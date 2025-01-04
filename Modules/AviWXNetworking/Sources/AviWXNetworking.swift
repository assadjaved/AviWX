//
//  AviWXNetworking.swift
//  Pods
//
//  Created by Asad Javed on 01/01/2025.
//

import SwiftNet

public protocol AviWXNetworkingType {
    func fetchMetar(for icaoId: String) async throws -> MetarDto?
    func fetchAirportInfo(for icaoId: String) async throws -> AirportDto?
}

public class AviWXNetworking: AviWXNetworkingType {
    
    let network: SwiftNetType
    
    public static let shared = AviWXNetworking()
    
    init(network: SwiftNetType = SwiftNet()) {
        self.network = network
    }
    
    public func fetchMetar(for icaoId: String) async throws -> MetarDto? {
        let request = AviWXMetarRequest(icaoId: icaoId)
        do {
            return try await network.request(request).first
        } catch {
            throw error
        }
    }
    
    public func fetchAirportInfo(for icaoId: String) async throws -> AirportDto? {
        let request = AviWXAirportInfoRequest(icaoId: icaoId)
        do {
            return try await network.request(request).first
        } catch {
            throw error
        }
    }
}
