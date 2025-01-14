//
//  MetarDto+Clouds.swift
//  Pods
//
//  Created by Asad Javed on 12/01/2025.
//

fileprivate let cloudCoverDescriptions: [String: String] = [
    "CLR": "☀️ Clear skies",
    "SKC": "☀️ Clear sky",
    "FEW": "🌤 Few",
    "SCT": "⛅️ Scattered",
    "BKN": "🌥 Broken",
    "OVC": "☁️ Overcast",
    "NSC": "☀️ No significant clouds",
    "TCU": "🌩 Towering cumulus",
    "CB": "⛈️ Cumulonimbus",
    "CAVOK": "Ceiling and visibility OK 👌🏼"
]

public extension MetarDto {
    var formattedCloudsReport: [String] {
        var reports = [String]()
        for cloud in clouds {
            var cloudReport = ""
            if let description = cloudCoverDescriptions[cloud.cover.trimmingCharacters(in: .whitespaces)] {
                cloudReport += description
            } else {
                cloudReport += cloud.cover
            }
            if let base = cloud.base {
                cloudReport += " @ \(base.formatWithComma()) feet"
            }
            reports.append(cloudReport)
        }
        return reports
    }
}

extension Int {
    func formatWithComma() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
