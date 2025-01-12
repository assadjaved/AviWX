//
//  MetarRow.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//


import SwiftUI

struct MetarRow: View {
    @ObservedObject var metarViewModel: MetarViewModel
    @EnvironmentObject private var services: AppServices
    
    let metarViewPrimaryCta: MetarViewCta
    let metarViewSecondaryCta: MetarViewCta?
    
    var body: some View {
        VStack {
            switch metarViewModel.metarState {
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
            case .value(let metar):
                NavigationLink {
                    MetarDetailsView(
                        metarDetailsViewModel: MetarDetailsViewModel(
                            metar: metar,
                            airportDataProviderService: services.airportDataProviderService
                        )
                    )
                } label: {
                    MetarView(
                        metar: metar,
                        metarViewPrimaryCta: metarViewPrimaryCta,
                        metarViewSecondaryCta: metarViewSecondaryCta
                    )
                }
                .buttonStyle(.plain)
            case .error:
                MetarErrorView {
                    Task { await fetchMetar() }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, style: StrokeStyle(lineWidth: 0.1))
        )
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
    
    private func fetchMetar() async {
        await metarViewModel.fetchMetar()
    }
}
