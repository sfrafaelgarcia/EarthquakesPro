//
//  Quake+Preview.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/1/25.
//

import Foundation

extension Quake {
    static var preview: Quake {
        var quake = Quake(magnitude: 0.34,
                          place: "Shakey Acres",
                          time: Date(timeIntervalSinceNow: -1000),
                          code: "nc73649170",
                          detail: URL(string: "https://example.com")!)
        quake.location = QuakeLocation(latitude: 37.3318, longitude: -121.8818)
        return quake
        
    }
}
