//
//  QuakeDetailMap.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/1/25.
//

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
    let location: QuakeLocation
    let tintColor: Color
    private var place: QuakePlace
    @State private var position: MapCameraPosition = .automatic
    
    init(location: QuakeLocation, tintColor: Color) {
        self.location = location
        self.tintColor = tintColor
        self.place = QuakePlace(location: location)
    }
    
    var body: some View {
        Map(position: $position) {
            Marker("", coordinate: place.location)
                .tint(tintColor)
        }
        .onAppear {
            withAnimation {
                var region = MKCoordinateRegion()
                region.center = place.location
                region.span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                position = .region(region)
            }
        }
    }
}

struct QuakePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), location: QuakeLocation) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
}

#Preview {
    //QuakeDetailMap()
}
