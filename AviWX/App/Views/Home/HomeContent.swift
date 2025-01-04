//
//  HomeContent.swift
//  AviWX
//
//  Created by Asad Javed on 04/01/2025.
//


import SwiftUI

struct HomeContent: View {
    @ObservedObject var listViewModel: MetarListViewModel
    
    @State private var searchText: String = ""
    
    private var noMetarsMessage: String {
        if searchText.isEmpty {
            return "🌦️ No METARs added yet. Use the search to find your favorite airports and view live weather updates."
        } else {
            return "🌦️ No METARs found for \"\(searchText)\"."
        }
    }
    
    var body: some View {
        VStack {
            if listViewModel.isMetarAvailable {
                TextField("Search airport...", text: $searchText)
                    .textStyle(.body)
                    .padding()
                    .frame(maxWidth: .infinity)
                Divider()
            }
            if listViewModel.metars.isEmpty {
                Text(noMetarsMessage)
                    .textStyle(.light)
                    .padding()
                Spacer()
            } else {
                ScrollView {
                    ForEach(listViewModel.metars, id: \.icaoId) { metarViewModel in
                        MetarRow(viewModel: metarViewModel)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 8)
                    }
                }
            }
        }
        .onChange(of: searchText) { _, value in
            listViewModel.searchMetar(for: value)
        }
    }
}
