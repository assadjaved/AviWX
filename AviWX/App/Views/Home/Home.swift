//
//  HomeScreen.swift
//  AviWX
//
//  Created by Asad Javed on 31/12/2024.
//

import SwiftUI
import AviWXStyling

struct Home: View {
    @ObservedObject var listViewModel: MetarListViewModel
    
    var body: some View {
        NavigationStack {
            HomeContent(listViewModel: listViewModel)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("🌦️ AviWX")
                        .textStyle(.heading)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Action when search button is tapped
                        print("Search button tapped")
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

#Preview {
    Home(listViewModel: MetarListViewModel())
}
