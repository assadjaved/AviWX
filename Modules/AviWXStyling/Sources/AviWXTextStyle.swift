//
//  AviWXTextStyle.swift
//  Pods
//
//  Created by Asad Javed on 02/01/2025.
//


public enum AviWXTextStyle {
    /// 24pt Regular
    case heading
    
    /// 16pt Regular
    case title
    
    /// 16pt Bold
    case titleEmphasis
    
    /// 14pt Regular
    case body
    
    /// 12pt Regular
    case bodySmall
    
    /// 14pt Bold
    case bodyEmphasis
    
    /// 12pt Bold
    case bodySmallEmphasis
    
    /// 14pt Light
    case light
    
    /// 12pt Light
    case lightSmall
    
    var font: (name: String, size: CGFloat) {
        switch self {
        case .heading:
            return (appFont.rawValue, 24)
        case .title:
            return (appFont.rawValue, 16)
        case .titleEmphasis:
            return ("\(appFont.rawValue)-Bold", 16)
        case .body:
            return (appFont.rawValue, 14)
        case .bodySmall:
            return (appFont.rawValue, 12)
        case .bodyEmphasis:
            return ("\(appFont.rawValue)-Bold", 14)
        case .bodySmallEmphasis:
            return ("\(appFont.rawValue)-Bold", 12)
        case .light:
            return ("\(appFont.rawValue)-Light", 14)
        case .lightSmall:
            return ("\(appFont.rawValue)-Light", 12)
        }
    }
}
