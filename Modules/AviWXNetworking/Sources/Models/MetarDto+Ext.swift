//
//  MetarDto+Ext.swift
//  Pods
//
//  Created by Asad Javed on 03/01/2025.
//


public extension MetarDto {
    var formattedTemp: String {
        "\(temp)°C"
    }
    
    var formatedDewp: String {
        "\(dewp)°C"
    }
    
    var formattedWind: String {
        switch wdir {
        case .int(let value):
            return "\(value)° @ \(wspd) kts"
        case .string(let value):
            return "\(value) @ \(wspd) kts"
        }
    }
    
    var formattedAltimInHpa: String {
        "\(Int(round(altim))) hPa"
    }
    
    var formattedAltimInHg: String {
        "\(String(format: "%.2f", altim * 0.02953)) inHg"
    }
    
    var airport: String {
        name
            .components(separatedBy: ",")
            .first?
            .trimmingCharacters(in: .whitespaces)
            .components(separatedBy: "/")
            .last?
            .trimmingCharacters(in: .whitespaces) ?? name
    }
    
    var city: String {
        name
            .components(separatedBy: ",")
            .first?
            .trimmingCharacters(in: .whitespaces)
            .components(separatedBy: "/")
            .first?
            .trimmingCharacters(in: .whitespaces) ?? ""
    }
    
    var countryCode: String {
        name
            .components(separatedBy: ",")
            .last?
            .trimmingCharacters(in: .whitespaces) ?? ""
    }

    var countryDetails: (name: String, flag: String) {
        let countryCode = countryCode
        let countryName = Locale.current.localizedString(forRegionCode: countryCode)
        let flag = countryCode
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value).map { String($0) } }
            .joined()
        return (name: countryName ?? countryCode, flag: flag)
    }
    
    var formattedReportTime: String {
        let reportTimeComponents = reportTime.components(separatedBy: " ")
        let data = reportTimeComponents.first?.components(separatedBy: "-").reversed().joined(separator: "-")
        let time = reportTimeComponents.last?.components(separatedBy: ":").dropLast().joined(separator: ":")
        if let data, let time {
            return "\(data) \(time) UTC"
        } else {
            return reportTime
        }
    }
    
    var formattedElevation: String {
        "\(Int(round(elev))) m / \(Int(round(elev * 3.28084))) ft"
    }
    
    var formattedVisibility: String {
        let rawMetarComponents = rawOb.components(separatedBy: " ")
        guard rawMetarComponents.count > 3 else {
            return "n/a"
        }
        let visibilityComponent  = rawMetarComponents[3]
        if let visibilityValue = Int(visibilityComponent ) {
            return "\(visibilityValue) meters"
        } else {
            return visibilityComponent
        }
    }
}
