//
//  MetarAvailabilityService.swift
//  AviWX
//
//  Created by Asad Javed on 07/01/2025.
//


import Foundation
import AviWXNetworking

class MetarAvailabilityService {
    
    @Published private(set) var availableMetars = [MetarViewModel]()
    
    private let metarStorageService: MetarStorageService
    private let metarDataProviderService: MetarDataProviderServiceType
    
    var metarsAvailable: Bool {
        !availableMetars.isEmpty
    }
    
    init(metarStorageService: MetarStorageService, metarDataProviderService: MetarDataProviderServiceType) {
        self.metarStorageService = metarStorageService
        self.metarDataProviderService = metarDataProviderService
        retrieveMetars()
    }
    
    private func retrieveMetars() {
        let icaoIds = metarStorageService.retrieve()
        availableMetars = icaoIds.map { MetarViewModel(icaoId: $0, metarDataProviderService: metarDataProviderService) }
    }
    
    func saveMetar(_ icaoId: String) throws {
        do {
            try metarStorageService.save(icaoId)
            availableMetars.insert(MetarViewModel(icaoId: icaoId, metarDataProviderService: metarDataProviderService), at: 0)
            availableMetars = availableMetars
        } catch {
            throw error
        }
    }
    
    func deleteMetar(_ icaoId: String) throws {
        do {
            try metarStorageService.delete(icaoId)
            availableMetars.removeAll { $0.icaoId == icaoId }
            availableMetars = availableMetars
        } catch {
            throw error
        }
    }
    
    func isExistingMetar(_ icaoId: String) -> Bool {
        metarStorageService.exists(icaoId)
    }
}
