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
    
    private let metarAvailabilityService: MetarAvailabilityService
    private let networking: AviWXNetworkingType
    
    init(
        metarAvailabilityService: MetarAvailabilityService,
        networking: AviWXNetworkingType
    ) {
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
            where: { $0.icaoId == icaoId }
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
        // TODO: - handle throw to show alert...
        try? metarAvailabilityService.saveMetar(icaoId)
    }
    
    func isExistingMetar(_ icaoId: String) -> Bool {
        metarAvailabilityService.isExistingMetar(icaoId)
    }
    
    func reset() {
        metarState = nil
    }
}
