//
//  MetarButtonState.swift
//  AviWX
//
//  Created by Asad Javed on 06/01/2025.
//

import SwiftUI

typealias IcaoId = String
typealias MetarButtonHandler = (IcaoId) -> Void

enum MetarViewButton {
    case refresh(handler: MetarButtonHandler)
    case add(handler: MetarButtonHandler)
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .refresh:
            RefreshButtonView()
        case .add:
            AddButtonView()
        }
    }
    
    var action: MetarButtonHandler {
        switch self {
        case .refresh(let handler):
            return handler
        case .add(let handler):
            return handler
        }
    }
}

private struct RefreshButtonView: View {
    var body: some View {
        Image(systemName: "arrow.clockwise")
            .imageScale(.medium)
            .foregroundColor(.blue)
    }
}

private struct AddButtonView: View {
    var body: some View {
        HStack(spacing: 2) {
            Text("Add")
                .textStyle(.bodySmall)
                .foregroundStyle(.white)
            Image(systemName: "plus")
                .imageScale(.small)
                .foregroundColor(.white)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black)
        )
    }
}
