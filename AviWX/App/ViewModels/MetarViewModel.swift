//
//  MetarInfoViewModel.swift
//  AviWX
//
//  Created by Asad Javed on 02/01/2025.
//


import AviWXNetworking

class MetarViewModel: ObservableObject {
    
    @Published var metarState: LoadableState<MetarDto> = .loading
    
    let icaoId: String
    private let metarDataProviderService: MetarDataProviderServiceType
    
    var metar: MetarDto? {
        if case .value(let metar) = metarState {
            return metar
        }
        return nil
    }
    
    init(icaoId: String, metarDataProviderService: MetarDataProviderServiceType) {
        self.icaoId = icaoId
        self.metarDataProviderService = metarDataProviderService
        Task { await fetchMetar() }
    }
    
    @MainActor
    func fetchMetar() async {
        metarState = .loading
        do {
            let metar = try await metarDataProviderService.fetchMetar(for: icaoId)
            if let metar {
                self.metarState = .value(metar)
            } else {
                self.metarState = .error(AviWXError.notFound)
            }
        } catch {
            self.metarState = .error(error)
        }
    }
}
