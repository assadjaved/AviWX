//
//  AirportDto.swift
//  Pods
//
//  Created by Asad Javed on 02/01/2025.
//

import CoreLocation

public struct AirportDto: Decodable {
    public let icaoId: String
    public let name: String
    public let lat: Double
    public let lon: Double
    public let country: String
    public let elev: Double
    public let runways: [RunwayDto]
    public let rwyNum: String
    public let freqs: String
}

public struct RunwayDto: Decodable {
    public let id: String
    public let dimension: String
    public let surface: String
}

public extension AirportDto {
    var coord2d: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
