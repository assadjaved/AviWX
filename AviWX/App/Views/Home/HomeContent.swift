//
//  HomeContent.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//


import SwiftUI

struct HomeContent: View {
    @ObservedObject var metarListViewModel: MetarListViewModel
    
    @State private var searchText: String = ""
    
    private var noMetarsMessage: String {
        if searchText.isEmpty {
            return "🌦️ No METARs added yet. Please add your favorite airports to view live weather updates."
        } else {
            return "🌦️ No METARs found for \"\(searchText)\"."
        }
    }
    
    var body: some View {
        VStack {
            if metarListViewModel.isMetarAvailable {
                TextField("Search airport...", text: $searchText)
                    .textStyle(.body)
                    .padding()
                    .frame(maxWidth: .infinity)
                Divider()
            }
            if metarListViewModel.metars.isEmpty {
                Text(noMetarsMessage)
                    .textStyle(.light)
                    .padding()
                Spacer()
            } else {
                ScrollView {
                    ForEach(metarListViewModel.metars, id: \.icaoId) { metarViewModel in
                        MetarRow(
                            viewModel: metarViewModel,
                            metarViewCta: .refresh { icaoId in
                                Task { await metarListViewModel.refreshMetar(icaoId) }
                            }
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                    }
                }
            }
        }
        .onChange(of: searchText) { _, value in
            metarListViewModel.filterMetars(for: value)
        }
    }
}
