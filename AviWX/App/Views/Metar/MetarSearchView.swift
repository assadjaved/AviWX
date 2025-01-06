//
//  AirportSearchView.swift
//  AviWX
//
//  Created by Asad Javed on 05/01/2025.
//


import SwiftUI

struct MetarSearchView: View {
    @ObservedObject var viewModel: MetarSearchViewModel
    @Binding var presentSearchAirport: Bool
    let metarViewCta: MetarViewButton
    
    @State private var icaoId = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Search airport 🛫")
                    .textStyle(.heading)
                Spacer()
                Button(action: {
                    presentSearchAirport = false
                }) {
                    Image(systemName: "xmark")
                }
            }
            .padding(.top, 16)
            Spacer()
                .frame(height: 16)
            TextField("Enter airport ICAO id - eg. OPLA", text: $icaoId)
                .textStyle(.body)
            Divider()
            if let result = viewModel.metarState {
                switch result {
                case .success(let metarViewModel):
                    MetarRow(
                        viewModel: metarViewModel,
                        metarViewCta: metarViewCta
                    )
                case .failure:
                    Text("Please enter a valid ICAO id - eg. OPLA 🛬")
                        .textStyle(.body)
                        .foregroundStyle(.red)
                        .padding(.top, 8)
                }
            }
            Spacer()
        }
        .padding()
        .onChange(of: icaoId) { _, icaoId in
            viewModel.searchAirport(with: icaoId)
        }
    }
}
