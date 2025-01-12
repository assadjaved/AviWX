//
//  MetarDataProviderService.swift
//  AviWX
//
//  Created by Asad Javed on 11/01/2025.
//


import AviWXNetworking


// MARK: - MetarDataProviderServiceType

protocol MetarDataProviderServiceType {
    func fetchMetar(for icaoId: String) async throws -> MetarDto?
}


// MARK: - AirportDataProviderServiceType

protocol AirportDataProviderServiceType {
    func fetchAirportInfo(for icaoId: String) async throws -> AirportDto?
}


// MARK: - MetarDataProviderService

class MetarDataProviderService {
    
    private let networking: AviWXNetworkingType
    
    init(networking: AviWXNetworkingType) {
        self.networking = networking
    }
}


// MARK: - MetarDataProviderServiceType Impl

extension MetarDataProviderService: MetarDataProviderServiceType {
    func fetchMetar(for icaoId: String) async throws -> MetarDto? {
        do {
            return try await networking.fetchMetar(for: icaoId)
        } catch {
            throw error
        }
    }
}


// MARK: - AirportDataProviderServiceType Impl

extension MetarDataProviderService: AirportDataProviderServiceType {
    func fetchAirportInfo(for icaoId: String) async throws -> AirportDto? {
        do {
            return try await networking.fetchAirportInfo(for: icaoId)
        } catch {
            throw error
        }
    }
}
