//
//  HomeScreen.swift
//  AviWX
//
//  Created by Asad Javed on 31/12/2024.
//

import SwiftUI
import AviWXStyling

struct Home: View {
    @ObservedObject var metarListViewModel: MetarListViewModel
    @ObservedObject var metarSearchViewModel: MetarSearchViewModel
    @State private var presentAirportSearch: Bool = false
    
    var body: some View {
        NavigationStack {
            HomeContent(metarListViewModel: metarListViewModel)
            .sheet(isPresented: $presentAirportSearch) {
                MetarSearchView(
                    metarSearchViewModel: metarSearchViewModel,
                    presentSearchAirport: $presentAirportSearch,
                    addMetar: addMetar(icaoId:),
                    isExistingMetar: isExistingMetar(icaoId:)
                )
                .presentationDetents([.medium, .large])
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("🌦️ AviWX")
                        .textStyle(.heading)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        presentAirportSearch = true
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
            }
        }
        .onChange(of: presentAirportSearch) { _, value in
            if !value {
                metarSearchViewModel.reset()
            }
        }
    }
    
    private func addMetar(icaoId: IcaoId) {
        presentAirportSearch = false
        metarListViewModel.addMetar(icaoId)
        metarListViewModel.reloadMetars()
    }
    
    private func isExistingMetar(icaoId: IcaoId) -> Bool {
        metarListViewModel.isExistingMetar(icaoId)
    }
}

#Preview {
    Home(
        metarListViewModel: MetarListViewModel(),
        metarSearchViewModel: MetarSearchViewModel()
    )
}
