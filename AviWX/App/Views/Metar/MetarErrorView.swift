//
//  MetarErrorView.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//


import SwiftUI

struct MetarErrorView: View {
    let refresh: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    refresh()
                }) {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.medium)
                        .foregroundColor(.blue)
                }
            }
            VStack {
                Text("🌩️ Unable to fetch METAR data.")
                    .textStyle(.light)
                Text("Please try again later.")
                    .textStyle(.light)
            }
        }
        .padding(16)
    }
}
