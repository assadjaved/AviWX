//
//  AviWXApp.swift
//  AviWX
//
//  Created by Asad Javed on 31/12/2024.
//

import SwiftUI
import AviWXNetworking

@main
struct AviWXApp: App {
    var body: some Scene {
        WindowGroup {
            Home(
                metarListViewModel: MetarListViewModel(),
                metarSearchViewModel: MetarSearchViewModel()
                
            )
        }
    }
}
