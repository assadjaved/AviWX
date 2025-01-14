//
//  MapView.swift
//  AviWX
//
//  Created by Asad Javed on 10/01/2025.
//


import SwiftUI
import MapKit

struct MapView: View {
    let title: String
    let coordinate: CLLocationCoordinate2D
    
    private let position: MapCameraPosition
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        self.position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
            )
        )
    }

    var body: some View {
        Map(
            initialPosition: position,
            interactionModes: [.zoom, .pan]
        ) {
            Annotation(title, coordinate: coordinate) {
                VStack {
                    HStack {
                        Image(systemName: "airplane")
                            .imageScale(.medium)
                            .foregroundStyle(.black)
                            .rotationEffect(.degrees(-45))
                    }
                    .padding(8)
                }
                .background {
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(8)
                }
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 4)
                .opacity(0.9)
            }
            .annotationTitles(.hidden)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(title:"IQBAL INTL 🇵🇰", coordinate: CLLocationCoordinate2D(latitude: 31.5205, longitude: 74.4047))
    }
}

