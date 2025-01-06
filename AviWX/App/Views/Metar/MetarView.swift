//
//  MetarView.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//

import SwiftUI
import AviWXNetworking

struct MetarView: View {
    let metar: MetarDto
    let metarViewCta: MetarViewButton
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(metar.icaoId)
                            .textStyle(.titleEmphasis)
                        Text("\("\u{2014}")")
                            .textStyle(.title)
                        Text(metar.airport)
                            .textStyle(.title)
                        Spacer()
                        Button(action: {
                            metarViewCta.action(metar.icaoId)
                        }) {
                            metarViewCta.view
                        }
                    }
                    Spacer()
                        .frame(height: 4)
                    Text("\(metar.city), \(metar.countryDetails.name) \(metar.countryDetails.flag)")
                        .textStyle(.body)
                        .foregroundStyle(.secondary)
                    Divider()
                    Spacer()
                        .frame(height: 8)
                    HStack {
                        VStack(spacing: 4) {
                            Text("〰️ Wind")
                                .textStyle(.bodySmall)
                            Text(metar.formattedWind)
                                .textStyle(.body)
                        }
                        Spacer()
                        VStack(spacing: 4) {
                            Text("🌡️ Temp")
                                .textStyle(.bodySmall)
                            Text(metar.formattedTemp)
                                .textStyle(.body)
                        }
                        Spacer()
                        VStack(spacing: 4) {
                            Text("🫧 Altimeter")
                                .textStyle(.bodySmall)
                            Text(metar.formattedAltimInHpa)
                                .textStyle(.body)
                        }
                        Spacer()
                        VStack(spacing: 4) {
                            Text("💧 Dew Point")
                                .textStyle(.bodySmall)
                            Text(metar.formatedDewp)
                                .textStyle(.body)
                        }
                    }
                }
            }
        }
        .padding(16)
    }
}
