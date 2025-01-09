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
    
    private let dependencies: AviWXDependencies
    private let services: AviWXServices
    
    private let metarListViewModel: MetarListViewModel
    private let metarSearchViewModel: MetarSearchViewModel
    
    init() {
        dependencies = AppDependencies()
        services = AppServices(dependencies: dependencies)
        
        metarListViewModel = MetarListViewModel(
            metarAvailabilityService: services.metarAvailabilityService
        )
        
        metarSearchViewModel = MetarSearchViewModel(
            metarAvailabilityService: services.metarAvailabilityService,
            networking: dependencies.networking
        )
    }
    
    var body: some Scene {
        WindowGroup {
            Home(
                metarListViewModel: metarListViewModel,
                metarSearchViewModel: metarSearchViewModel
                
            )
        }
    }
}
