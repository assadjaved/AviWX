//
//  MetarDto.swift
//  Pods
//
//  Created by Asad Javed on 02/01/2025.
//


public struct MetarDto: Decodable {
    public let metarId: Int
    public let icaoId: String
    public let reportTime: String
    public let temp: Double
    public let dewp: Double
    public let wdir: Variable
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

extension MetarDto {
    enum CodingKeys: String, CodingKey {
        case metarId = "metar_id"
        case icaoId
        case reportTime
        case temp
        case dewp
        case wdir
        case wspd
        case altim
        case rawOb
        case name
        case clouds
    }
    
    public enum Variable {
        case int(Int)
        case string(String)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        metarId = try container.decode(Int.self, forKey: .metarId)
        icaoId = try container.decode(String.self, forKey: .icaoId).uppercased()
        reportTime = try container.decode(String.self, forKey: .reportTime)
        temp = try container.decode(Double.self, forKey: .temp)
        dewp = try container.decode(Double.self, forKey: .dewp)
        wspd = try container.decode(Int.self, forKey: .wspd)
        altim = try container.decode(Double.self, forKey: .altim)
        rawOb = try container.decode(String.self, forKey: .rawOb)
        name = try container.decode(String.self, forKey: .name)
        clouds = try container.decode([CloudDto].self, forKey: .clouds)
        
        if let intValue = try? container.decode(Int.self, forKey: .wdir) {
            wdir = .int(intValue)
        } else if let stringValue = try? container.decode(String.self, forKey: .wdir) {
            wdir = .string(stringValue)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .wdir, in: container, debugDescription: "Invalid wdir value")
        }
    }
}
