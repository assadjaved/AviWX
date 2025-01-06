//
//  MetarListViewModel.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//


import Foundation
import AviWXNetworking

class MetarListViewModel: ObservableObject {
    
    @Published var metars = [MetarViewModel]()
    
    private let storage: AviWXStorage
    private let networking: AviWXNetworkingType
    private var availableMetars = [MetarViewModel]()
    
    var isMetarAvailable: Bool {
        !availableMetars.isEmpty
    }
    
    init(storage: AviWXStorage = UserDefaults.standard,
         networking: AviWXNetworkingType = AviWXNetworking.shared) {
        self.storage = storage
        self.networking = networking
        loadMetars()
    }
    
    private func loadMetars() {
        let icaoIds = storage.retrieve()
        availableMetars = icaoIds.map { MetarViewModel(icaoId: $0, networking: networking) }
        metars = availableMetars
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
    
    func reloadMetars() {
        loadMetars()
    }
    
    func addMetar(_ icaoId: String) {
        storage.save(icaoId)
    }
    
    func removeMetar(_ icaoId: String) {
        storage.delete(icaoId)
    }
    
    func isExistingMetar(_ icaoId: String) -> Bool {
        storage.exists(icaoId)
    }
}
