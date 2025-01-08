//
//  AviWXServices.swift
//  AviWX
//
//  Created by Asad Javed on 08/01/2025.
//


protocol AviWXServices {
    var metarStorageService: MetarStorageService { get }
    var metarAvailabilityService: MetarAvailabilityService { get }
}

class AppServices: AviWXServices {
    let dependencies: AviWXDependencies
    let metarStorageService: MetarStorageService
    let metarAvailabilityService: MetarAvailabilityService
    
    init(dependencies: AviWXDependencies) {
        self.dependencies = dependencies
        metarStorageService = MetarStorageService(storage: dependencies.storage)
        metarAvailabilityService = MetarAvailabilityService(
            metarStorageService: metarStorageService,
            networking: dependencies.networking
        )
    }
}
