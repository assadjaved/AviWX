//
//  AviWXServices.swift
//  AviWX
//
//  Created by Asad Javed on 08/01/2025.
//


import Foundation

protocol AviWXServices {
    var metarStorageService: MetarStorageService { get }
    var metarDataProviderService: MetarDataProviderServiceType { get }
    var airportDataProviderService: AirportDataProviderServiceType { get }
    var metarAvailabilityService: MetarAvailabilityService { get }
}

class AppServices: AviWXServices, ObservableObject {
    let metarStorageService: MetarStorageService
    let metarDataProviderService: MetarDataProviderServiceType
    let airportDataProviderService: AirportDataProviderServiceType
    let metarAvailabilityService: MetarAvailabilityService
    
    init(dependencies: AviWXDependencies) {
        let dataProviderService = MetarDataProviderService(networking: dependencies.networking)
        metarDataProviderService = dataProviderService
        airportDataProviderService = dataProviderService
        metarStorageService = MetarStorageService(storage: dependencies.storage)
        metarAvailabilityService = MetarAvailabilityService(
            metarStorageService: metarStorageService,
            metarDataProviderService: metarDataProviderService
        )
    }
}
