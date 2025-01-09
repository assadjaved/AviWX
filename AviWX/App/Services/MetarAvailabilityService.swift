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
    private let networking: AviWXNetworkingType
    
    var metarsAvailable: Bool {
        !availableMetars.isEmpty
    }
    
    init(metarStorageService: MetarStorageService, networking: AviWXNetworkingType) {
        self.metarStorageService = metarStorageService
        self.networking = networking
        retrieveMetars()
    }
    
    private func retrieveMetars() {
        let icaoIds = metarStorageService.retrieve()
        availableMetars = icaoIds.map { MetarViewModel(icaoId: $0, networking: networking) }
    }
    
    func saveMetar(_ icaoId: String) {
        guard metarStorageService.save(icaoId) else { return }
        availableMetars.insert(MetarViewModel(icaoId: icaoId, networking: networking), at: 0)
        availableMetars = availableMetars
    }
    
    func deleteMetar(_ icaoId: String) {
        guard metarStorageService.delete(icaoId) else { return }
        availableMetars.removeAll { $0.icaoId == icaoId }
        availableMetars = availableMetars
    }
    
    func isExistingMetar(_ icaoId: String) -> Bool {
        metarStorageService.exists(icaoId)
    }
}
