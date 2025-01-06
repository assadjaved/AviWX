//
//  HomeScreen.swift
//  AviWX
//
//  Created by Asad Javed on 31/12/2024.
//

import SwiftUI
import AviWXStyling

struct Home: View {
    @ObservedObject var listViewModel: MetarListViewModel
    @State private var presentSearchAirport: Bool = false
    
    var body: some View {
        NavigationStack {
            HomeContent(
                listViewModel: listViewModel,
                metarViewCta: .refresh { icaoId in
                    Task { await listViewModel.refreshMetar(icaoId) }
                }
            )
            .sheet(isPresented: $presentSearchAirport) {
                MetarSearchView(
                    viewModel: MetarSearchViewModel(),
                    presentSearchAirport: $presentSearchAirport,
                    metarViewCta: .add { icaoId in
                        listViewModel.addMetar(icaoId)
                    }
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
                        // Action when search button is tapped
                        presentSearchAirport.toggle()
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

#Preview {
    Home(listViewModel: MetarListViewModel())
}
