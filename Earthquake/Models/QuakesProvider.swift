//
//  QuakesProvider.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/1/25.
//

import Foundation

@Observable
class QuakesProvider {
    
    var quakes: [Quake] = []
    
    let client: QuakeClient
    
    func fetchQuakes() async throws {
        let lastedQuakes = try await client.quakes
        self.quakes = lastedQuakes
    }
    func deleteQuakes(atOffsets offsets: IndexSet) {
        quakes.remove(atOffsets: offsets)
    }
    func location(for quake: Quake) async throws -> QuakeLocation {
        return try await client.quakeLocation(from: quake.detail)
    }
    
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
}
