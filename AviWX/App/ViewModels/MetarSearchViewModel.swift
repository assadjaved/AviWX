//
//  MetarSearchViewModel.swift
//  AviWX
//
//  Created by Asad Javed on 05/01/2025.
//


import AviWXNetworking

class MetarSearchViewModel: ObservableObject {
    
    @Published var metarState: Result<MetarViewModel, Error>?
    
    private enum Constants {
        static let icaoIdLength = 4
    }
    private let networking: AviWXNetworkingType
    
    init(networking: AviWXNetworkingType = AviWXNetworking.shared) {
        self.networking = networking
    }
    
    func searchAirport(with icaoId: String) {
        guard icaoId.count >= Constants.icaoIdLength else {
            metarState = nil
            return
        }
        
        // icao id should be 4 characters long
        if icaoId.count == Constants.icaoIdLength {
            metarState = .success(MetarViewModel(icaoId: icaoId, networking: networking))
        } else {
            metarState = .failure(AviWXError.notFound)
        }
    }
}
