//
//  AviWXFontModifier.swift
//  Pods
//
//  Created by Asad Javed on 02/01/2025.
//


import SwiftUI

struct AviWXFontModifier: ViewModifier {
    let textStyle: AviWXTextStyle
    
    func body(content: Content) -> some View {
        let font = textStyle.font
        content
            .font(.custom(font.name, size: font.size))
    }
}
