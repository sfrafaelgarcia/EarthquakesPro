//
//  QuakeDetail.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/1/25.
//

import SwiftUI

struct QuakeDetail: View {
    let quake: Quake
    @Environment(QuakesProvider.self) private var quakesProvider
    @State private var location: QuakeLocation? = nil
    
    var body: some View {
        VStack {
            if let location = self.location {
                QuakeDetailMap(location: location, tintColor: quake.color)
                    .ignoresSafeArea(.container)
            }
            QuakeMagnitude(quake: quake)
            Text(quake.place)
                .font(.title3)
                .fontWeight(.bold)
            Text("\(quake.time.formatted())")
                .foregroundStyle(.secondary)
            if let location = quake.location {
                Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
            }
        }
        // The system automatically cancels a view's tasks when the view disappears.
        .task {
            // Check if the quake detail view needs a location
            if location == nil {
                // Display the quake's location information, if it exists.
                if let quakeLocation = quake.location {
                    location = quakeLocation
                } else {
                    location = try? await quakesProvider.location(for: quake)
                }
            }
        }
            
    }
}

#Preview {
    QuakeDetail(quake: Quake.preview)
        .environment(QuakesProvider(client: QuakeClient(downloader: TestDownloader())))
}
