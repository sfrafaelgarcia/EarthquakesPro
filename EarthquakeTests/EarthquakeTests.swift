//
//  EarthquakeTests.swift
//  EarthquakeTests
//
//  Created by Rafael Garcia on 4/27/25.
//

import Foundation
import Testing
@testable import Earthquake

struct EarthquakeTests {

    @Test func geoJSONDecoderDecodesQuake() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        #expect(quake.code == "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550 / 1000.0)
        let expectedTime = Date(timeIntervalSince1970: expectedSeconds)
        #expect(quake.time == expectedTime)
    }
    
    @Test func geoJSONDecoderDecodesGeoJSON() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let decoded = try decoder.decode(GeoJSON.self, from: testQuakesData)
        #expect(decoded.quakes.count == 6)
        #expect(decoded.quakes[0].code == "73649170")

        let expectedSeconds = TimeInterval(1636129710550 / 1000.0)
        let expectedTime = Date(timeIntervalSince1970: expectedSeconds)
        #expect(decoded.quakes[0].time == expectedTime)
    }

}
