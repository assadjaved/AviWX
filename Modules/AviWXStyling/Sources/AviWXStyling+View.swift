//
//  AviWXStyling+View.swift
//  Pods
//
//  Created by Asad Javed on 02/01/2025.
//


import SwiftUI

public extension View {
    func textStyle(_ textStyle: AviWXTextStyle) -> some View {
        self.modifier(AviWXFontModifier(textStyle: textStyle))
    }
}
