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
                    presentSearchAirport: $presentAirportSearch
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
                            .imageScale(.small)
                            .foregroundColor(.black)
                            .padding(4)
                            .overlay(
                                Circle()
                                    .stroke(.black, style: StrokeStyle(lineWidth: 0.5))
                            )
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
}
