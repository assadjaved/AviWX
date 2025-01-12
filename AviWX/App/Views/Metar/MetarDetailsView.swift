//
//  MetarDetailsView.swift
//  AviWX
//
//  Created by Asad Javed on 11/01/2025.
//


import SwiftUI
import AviWXStyling
import AviWXNetworking

struct MetarDetailsView: View {
    
    @ObservedObject var metarDetailsViewModel: MetarDetailsViewModel
    
    private var metar: MetarDto {
        metarDetailsViewModel.metar
    }
    
    var body: some View {
        VStack {
            ScrollView {
                MetarDetailsMapView(metarDetailsViewModel: metarDetailsViewModel)
                VStack {
                    Text(metar.icaoId)
                        .textStyle(.heading)
                        .foregroundStyle(.black)
                    Spacer()
                        .frame(height: 4)
                    Text(metar.airport)
                        .textStyle(.title)
                    Spacer()
                        .frame(height: 4)
                    Text("\(metar.city), \(metar.countryDetails.name) \(metar.countryDetails.flag)")
                        .textStyle(.body)
                        .foregroundStyle(.secondary)
                }
                .padding()
                Divider()
                HStack {
                    Text("🕘  Report Time:")
                        .textStyle(.light)
                    Text(metar.formattedReportTime)
                        .textStyle(.body)
                }
                .padding()
                Divider()
                HStack {
                    Spacer()
                    VStack {
                        VStack(spacing: 8) {
                            Text("〰️  Wind")
                                .textStyle(.light)
                            Text(metar.formattedWind)
                                .textStyle(.title)
                        }
                        Spacer()
                            .frame(height: 32)
                        VStack(spacing: 8) {
                            Text("🌡️  Temp")
                                .textStyle(.light)
                            Text(metar.formattedTemp)
                                .textStyle(.title)
                        }
                        Spacer()
                            .frame(height: 32)
                        VStack(spacing: 8) {
                            Text("👀  Visibility")
                                .textStyle(.light)
                            Text(metar.formattedVisibility)
                                .textStyle(.title)
                        }
                    }
                    Spacer()
                        .frame(width: 44)
                    VStack {
                        VStack(spacing: 8) {
                            Text("⏱️  Altimeter")
                                .textStyle(.light)
                            Text("\(metar.formattedAltimInHpa) / \(metar.formattedAltimInHg)")
                                .textStyle(.title)
                        }
                        Spacer()
                            .frame(height: 32)
                        VStack(spacing: 8) {
                            Text("💧 Dew Point")
                                .textStyle(.light)
                            Text(metar.formatedDewp)
                                .textStyle(.title)
                        }
                        Spacer()
                            .frame(height: 32)
                        VStack(spacing: 8) {
                            Text("🗻  Elevation")
                                .textStyle(.light)
                            Text(metar.formattedElevation)
                                .textStyle(.title)
                        }
                    }
                    Spacer()
                }
                .padding()
                Divider()
            }
        }
        .navigationTitle(metar.icaoId)
    }
}

struct MetarDetailsMapView: View {
    
    @ObservedObject var metarDetailsViewModel: MetarDetailsViewModel
    
    var body: some View {
        switch metarDetailsViewModel.airportState {
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
                .padding()
        case .value(let airport):
            MapView(title: airport.icaoId, coordinate: airport.coord2d)
                .frame(width: UIScreen.main.bounds.width, height: 256)
        case .error:
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .imageScale(.medium)
                Text("Sorry, can't load airport map")
                    .textStyle(.body)
            }
        }
    }
}
