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
                VStack {
                    Text("Clouds")
                        .textStyle(.heading)
                    Spacer()
                        .frame(height: 16)
                    ForEach(metar.formattedCloudsReport, id: \.self) { cloud in
                        Text(cloud)
                            .textStyle(.title)
                        Spacer()
                            .frame(height: 8)
                    }
                }
                .padding()
                Divider()
                VStack {
                    Text("Raw METAR")
                        .textStyle(.heading)
                    Spacer()
                        .frame(height: 16)
                    Text(metar.rawOb)
                        .font(.system(.body, design: .monospaced))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .shadow(radius: 2)
                        
                }
                .padding()
                Divider()
                VStack {
                    Text("Runways")
                        .textStyle(.heading)
                    Spacer()
                        .frame(height: 16)
                    RunwaysView(metarDetailsViewModel: metarDetailsViewModel)
                }
                .padding()
                VStack {
                    Text("📡 Frequencies")
                        .textStyle(.heading)
                    Spacer()
                        .frame(height: 16)
                    FrequenciesView(metarDetailsViewModel: metarDetailsViewModel)
                }
                .padding()
            }
        }
        .navigationTitle(metar.icaoId)
    }
}

struct MetarDetailsContentView<Content: View>: View {
    
    @ObservedObject var metarDetailsViewModel: MetarDetailsViewModel
    let content: (AirportDto) -> Content
    
    init(
        metarDetailsViewModel: MetarDetailsViewModel,
        @ViewBuilder content: @escaping (AirportDto) -> Content
    ) {
        self.metarDetailsViewModel = metarDetailsViewModel
        self.content = content
    }
    
    var body: some View {
        switch metarDetailsViewModel.airportState {
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
                .padding()
        case .value(let airport):
            content(airport)
        case .error:
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .imageScale(.medium)
                Text("Sorry, can't load airport data at the moment.")
                    .textStyle(.body)
            }
        }
    }
}

struct MetarDetailsMapView: View {
    
    @ObservedObject var metarDetailsViewModel: MetarDetailsViewModel
    
    var body: some View {
        MetarDetailsContentView(
            metarDetailsViewModel: metarDetailsViewModel
        ) { airport in
            MapView(title: airport.icaoId, coordinate: airport.coord2d)
                .frame(width: UIScreen.main.bounds.width, height: 256)
        }
    }
}

struct RunwaysView: View {
    
    @ObservedObject var metarDetailsViewModel: MetarDetailsViewModel
    
    private var windDir: MetarDto.Variable {
        metarDetailsViewModel.metar.wdir
    }
    
    private var windSpeed: Int {
        metarDetailsViewModel.metar.wspd
    }
    
    var body: some View {
        MetarDetailsContentView(
            metarDetailsViewModel: metarDetailsViewModel
        ) { airport in
            ForEach(airport.runways, id: \.id) { runway in
                RunwayView(runway: runway, windDirection: windDir, windSpeed: windSpeed)
                Divider()
            }
        }
    }
}

struct FrequenciesView: View {
    @ObservedObject var metarDetailsViewModel: MetarDetailsViewModel
    
    var body: some View {
        MetarDetailsContentView(
            metarDetailsViewModel: metarDetailsViewModel
        ) { airport in
            ForEach(Array(airport.frequencies), id: \.self) { frequencyData in
                if let (type, frequency) = frequencyComponents(from: frequencyData) {
                    Text("\(type): \(frequency)")
                        .font(.system(.body, design: .monospaced))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }
            }
        }
    }
    
    private func frequencyComponents(from frequencyData: String) -> (type: String, frequency: String)? {
        let components = frequencyData.components(separatedBy: ",")
        guard components.count == 2 else { return nil }
        return (type: components[0], frequency: components[1])
    }
}
