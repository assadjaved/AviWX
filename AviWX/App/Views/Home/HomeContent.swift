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
    
    var body: some View {
        VStack {
            TextField("Search airport...", text: $searchText)
                .textStyle(.body)
                .padding()
                .frame(maxWidth: .infinity)
            Divider()
            if listViewModel.metars.isEmpty {
                Text("🌦️ No METARs added yet. Use the search to find your favorite airports and view live weather updates.")
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
