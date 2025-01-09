//
//  MetarViewCta.swift
//  AviWX
//
//  Created by Asad Javed on 06/01/2025.
//

import SwiftUI

typealias IcaoId = String
typealias MetarCtaHandler = (IcaoId) -> Void

enum MetarViewCta {
    case delete(handler: MetarCtaHandler)
    case refresh(handler: MetarCtaHandler)
    case add(handler: MetarCtaHandler)
    case added
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .delete:
            DeleteCtaView()
        case .refresh:
            RefreshCtaView()
        case .add:
            AddCtaView()
        case .added:
            AddedCtaView()
        }
    }
    
    var action: MetarCtaHandler? {
        switch self {
        case .delete(let handler):
            return handler
        case .refresh(let handler):
            return handler
        case .add(let handler):
            return handler
        case .added:
            return nil
        }
    }
}

private struct RefreshCtaView: View {
    var body: some View {
        Image(systemName: "arrow.clockwise")
            .imageScale(.small)
            .foregroundColor(.black)
    }
}

private struct AddCtaView: View {
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

private struct AddedCtaView: View {
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "checkmark")
                .imageScale(.small)
                .foregroundStyle(.black)
            Text("Added")
                .textStyle(.bodySmall)
                .foregroundStyle(.black)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.green)
        )
    }
}

private struct DeleteCtaView: View {
    var body: some View {
        Image(systemName: "trash")
            .imageScale(.small)
            .foregroundStyle(.red)
    }
}
