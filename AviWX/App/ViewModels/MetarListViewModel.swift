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
//        let icaoIds = ["OPLA", "OPKC", "EGKK", "EGLL", "KJFK", "KLAX"]
        availableMetars = icaoIds.map { MetarViewModel(icaoId: $0, networking: networking) }
        metars = availableMetars
    }
    
    func searchMetar(for searchText: String) {
        guard !searchText.isEmpty else {
            metars = availableMetars
            return
        }

        let searchText = searchText.lowercased()
        
        metars = availableMetars.filter { metarViewModel in
            // search by icaoId
            if metarViewModel.icaoId.lowercased().contains(searchText) {
                return true
            }
            
            // search by airport name or country name
            if let metar = metarViewModel.metar {
                return metar.name.lowercased().contains(searchText) ||
                       metar.countryDetails.name.lowercased().contains(searchText)
            }
            
            return false
        }
    }
    
    func refreshMetar(_ icaoId: String) async {
        guard let metarViewModel = availableMetars.first(where: { $0.icaoId == icaoId }) else { return }
        await metarViewModel.fetchMetar()
    }
    
    func addMetar(_ icaoId: String) {
        storage.save(icaoId)
    }
}
