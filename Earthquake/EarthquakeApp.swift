//
//  EarthquakeApp.swift
//  Earthquake
//
//  Created by Rafael Garcia on 4/27/25.
//

import SwiftUI

@main
struct EarthquakeApp: App {
    @State var quakeProvider = QuakesProvider()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(quakeProvider)
        }
    }
}
