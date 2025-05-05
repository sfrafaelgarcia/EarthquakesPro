//
//  QuakeRow.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/1/25.
//

import SwiftUI

struct QuakeRow: View {
    var quake: Quake
    
    var body: some View {
        HStack {
            QuakeMagnitude(quake: quake)
                .padding()
            VStack(alignment: .leading) {
                Text(quake.place)
                    .font(.headline)
                Text(quake.time.formatted(.relative(presentation: .named)))
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let previewQuake = Quake(magnitude: 1.0,
                                    place: "Shakey Acres",
                                    time: Date(timeIntervalSinceNow: -1000),
                                    code: "nc73649170",
                                    detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!)
    QuakeRow(quake: previewQuake)
}
