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
    
    @StateObject private var services = AppServices(dependencies: AppDependencies())
    
    var body: some Scene {
        WindowGroup {
            Home(
                metarListViewModel: MetarListViewModel(
                    metarAvailabilityService: services.metarAvailabilityService
                ),
                metarSearchViewModel: MetarSearchViewModel(
                    metarAvailabilityService: services.metarAvailabilityService,
                    metarDataProviderService: services.metarDataProviderService
                )
            )
            .environmentObject(services)
        }
    }
}
