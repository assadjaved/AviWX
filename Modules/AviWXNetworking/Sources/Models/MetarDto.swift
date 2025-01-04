//
//  MetarDto.swift
//  Pods
//
//  Created by Asad Javed on 02/01/2025.
//


public struct MetarDto: Decodable {
    public let icaoId: String
    public let reportTime: String
    public let temp: Double
    public let dewp: Double
    public let wdir: Int
    public let wspd: Int
    public let altim: Double
    public let rawOb: String
    public let name: String
    public let clouds: [CloudDto]
}

public struct CloudDto: Decodable {
    public let cover: String
    public let base: Int?
}
