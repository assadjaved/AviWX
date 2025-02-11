//
//  RunwayView.swift
//  AviWX
//
//  Created by Asad Javed on 19/01/2025.
//

import SwiftUI
import AviWXStyling
import AviWXNetworking

struct RunwayView: View {
    let runway: RunwayDto
    let windDirection: MetarDto.Variable
    let windSpeed: Int
    
    private var runwayId: String {
        runway.id
    }
    
    private var alignment: Double {
        runway.alignmentDegree
    }
    
    private var runway1: String {
        runwayId.components(separatedBy: "/").first!
    }
    
    private var runway2: String {
        runwayId.components(separatedBy: "/").last!
    }
    
    private var windDir: Int? {
        switch windDirection {
        case .int(let value):
            return value
        case .string:
            return nil
        }
    }
    
    private let runwayWidth = 50.0
    private let runwayLength = UIScreen.main.bounds.width * 0.8

    var body: some View {
        VStack {
            if let windDir {
                VStack {
                    Text("↑")
                        .font(.title)
                        .rotationEffect(.degrees(Double(windDir)))
                        .rotationEffect(.degrees(180))
                    Text("\(windDir)° @ \(Int(windSpeed)) kt")
                        .textStyle(.light)
                }
            }
            // Runway container
            ZStack {
                ZStack {
                    Circle()
                        .stroke(
                            Color.gray,
                            style: StrokeStyle(
                                lineWidth: 1,
                                lineCap: .round,
                                dash: [5, 10] // Add a dashed pattern
                            )
                        )
                        .frame(width: UIScreen.main.bounds.size.width * 0.9)
                    
                    // Add angle markings
                    ForEach(0..<4) { index in
                        let angle = Double(index) * 90
                        VStack {
                            Text("\(Int(angle))")
                                .textStyle(.body)
                                .foregroundColor(.black)
                                .padding(4)
                                .background(Color.yellow)
                                .cornerRadius(8)
                                .rotationEffect(.degrees(-angle)) // Counter-rotate text to keep it upright
                            Spacer()
                        }
                        .frame(height: 390)
                        .rotationEffect(.degrees(angle)) // Rotate around the circle
                    }
                }
                
                ZStack {
                    // Runway background
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray)
                        .frame(width: runwayWidth, height: runwayLength)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    // Runway edge lines
                    VStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 4)
                            .offset(y: -runwayLength / 2 + 10)
                        Spacer()
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 4)
                            .offset(y: runwayLength / 2 - 10)
                    }
                    .frame(width: runwayWidth)

                    // Runway centerline
                    VStack(spacing: runwayLength / 8) {
                        ForEach(0..<5, id: \.self) { _ in
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: runwayWidth / 20, height: 8)
                        }
                    }

                    // Runway number and threshold markings
                    VStack {
                        // Top threshold markings and number
                        VStack(spacing: 5) {
                            HStack(spacing: 8) {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: runwayWidth / 4, height: 6)
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: runwayWidth / 4, height: 6)
                            }
                            Text(runway2)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(180))
                        }
                        .padding(.top, 20)

                        Spacer()

                        // Bottom threshold markings and number
                        VStack(spacing: 5) {
                            Text(runway1)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            HStack(spacing: 8) {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: runwayWidth / 4, height: 6)
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: runwayWidth / 4, height: 6)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .frame(height: runwayLength)
                }
                .rotationEffect(.degrees(alignment))
            }

            // Additional information below the runway
            Text("Runway: \(runwayId)")
                .font(.headline)
                .padding(.top, 20)
        }
    }
}
