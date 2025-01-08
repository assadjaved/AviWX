//
//  MetarListViewModel.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//


import Foundation
import AviWXNetworking
import AviWXStorage
import Combine

class MetarListViewModel: ObservableObject {
    
    @Published var metars = [MetarViewModel]()
    
    private let metarStorageService: MetarStorageService
    private let metarAvailabilityService: MetarAvailabilityService
    private var cancellables = Set<AnyCancellable>()
    
    private var availableMetars: [MetarViewModel] {
        metarAvailabilityService.availableMetars
    }
    
    var metarsAvailable: Bool {
        metarAvailabilityService.metarsAvailable
    }
    
    init(metarStorageService: MetarStorageService, metarAvailabilityService: MetarAvailabilityService) {
        self.metarStorageService = metarStorageService
        self.metarAvailabilityService = metarAvailabilityService
        bindings()
    }
    
    private func bindings() {
        metarAvailabilityService
            .$availableMetars
            .receive(on: DispatchQueue.main)
            .sink { [weak self] metars in
                self?.metars = metars
            }
            .store(in: &cancellables)
    }
    
    func filterMetars(for filterText: String) {
        guard !filterText.isEmpty else {
            metars = availableMetars
            return
        }

        let filterText = filterText.lowercased()
        
        metars = availableMetars.filter { metarViewModel in
            // search by icaoId
            if metarViewModel.icaoId.lowercased().contains(filterText) {
                return true
            }
            
            // search by airport name or country name
            if let metar = metarViewModel.metar {
                return metar.name.lowercased().contains(filterText) ||
                       metar.countryDetails.name.lowercased().contains(filterText)
            }
            
            return false
        }
    }
    
    func refreshMetar(_ icaoId: String) async {
        guard let metarViewModel = availableMetars.first(where: { $0.icaoId == icaoId }) else { return }
        await metarViewModel.fetchMetar()
    }
    
    func deleteMetar(_ icaoId: String) {
        metarStorageService.delete(icaoId)
    }
}
