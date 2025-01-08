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
        fetchAvailableMetars()
    }
    
    func fetchAvailableMetars() {
        let icaoIds = metarStorageService.retrieve()
        availableMetars = icaoIds.map { MetarViewModel(icaoId: $0, networking: networking) }
    }
}