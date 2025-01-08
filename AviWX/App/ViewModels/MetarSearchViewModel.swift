//
//  MetarSearchViewModel.swift
//  AviWX
//
//  Created by Asad Javed on 05/01/2025.
//


import AviWXNetworking

class MetarSearchViewModel: ObservableObject {
    
    @Published private(set) var metarState: Result<MetarViewModel, Error>?
    
    private enum Constants {
        static let icaoIdLength = 4
    }
    
    private let metarStorageService: MetarStorageService
    private let metarAvailabilityService: MetarAvailabilityService
    private let networking: AviWXNetworkingType
    
    init(
        metarStorageService: MetarStorageService,
        metarAvailabilityService: MetarAvailabilityService,
        networking: AviWXNetworkingType
    ) {
        self.metarStorageService = metarStorageService
        self.metarAvailabilityService = metarAvailabilityService
        self.networking = networking
    }
    
    func searchAirport(with icaoId: String) {
        guard icaoId.count >= Constants.icaoIdLength else {
            metarState = nil
            return
        }
        
        // check if the metar is already available
        if let metarViewModel = metarAvailabilityService.availableMetars.first(
            where: { $0.icaoId.lowercased() == icaoId.lowercased() }
        ) {
            metarState = .success(metarViewModel)
            return
        }
        
        // icao id should be 4 characters long
        if icaoId.count == Constants.icaoIdLength {
            metarState = .success(MetarViewModel(icaoId: icaoId, networking: networking))
        } else {
            metarState = .failure(AviWXError.notFound)
        }
    }
    
    func saveMetar(_ icaoId: String) {
        metarStorageService.save(icaoId)
    }
    
    func isExistingMetar(_ icaoId: String) -> Bool {
        metarStorageService.exists(icaoId)
    }
    
    func reloadMetars() {
        metarAvailabilityService.fetchAvailableMetars()
    }
    
    func reset() {
        metarState = nil
    }
}
