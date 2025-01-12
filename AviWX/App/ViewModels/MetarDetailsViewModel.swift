//
//  MetarDetailsViewModel.swift
//  AviWX
//
//  Created by Asad Javed on 11/01/2025.
//


import AviWXNetworking

class MetarDetailsViewModel: ObservableObject {
    
    @Published var airportState: LoadableState<AirportDto> = .loading
    
    let metar: MetarDto
    
    private let airportDataProviderService: AirportDataProviderServiceType
    
    init(metar: MetarDto, airportDataProviderService: AirportDataProviderServiceType) {
        self.metar = metar
        self.airportDataProviderService = airportDataProviderService
        Task { await fetchAirport() }
    }
    
    @MainActor
    private func fetchAirport() async {
        airportState = .loading
        do {
            let airport = try await airportDataProviderService.fetchAirportInfo(for: metar.icaoId)
            if let airport {
                self.airportState = .value(airport)
            } else {
                self.airportState = .error(AviWXError.notFound)
            }
        } catch {
            self.airportState = .error(error)
        }
    }
}
