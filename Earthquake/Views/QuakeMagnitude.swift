//
//  QuakeMagnitude.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/1/25.
//

import SwiftUI

struct QuakeMagnitude: View {
    var quake: Quake
    
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.black)
            .frame(width: 60, height: 40)
            .overlay(
                Text("\(quake.magnitude.formatted(.number.precision(.fractionLength(1))))")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(quake.color)
            )
    }
}

#Preview {
    let previewQuake = Quake(magnitude: 1.0,
                                    place: "Shakey Acres",
                                    time: Date(timeIntervalSinceNow: -1000),
                                    code: "nc73649170",
                                    detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!)
    QuakeMagnitude(quake: previewQuake)
}
