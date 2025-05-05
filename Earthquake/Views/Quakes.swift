//
//  Quakes.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/2/25.
//

import SwiftUI

let staticData: [Quake] = [
    Quake(magnitude: 0.8,
          place: "Shakey Acres",
          time: Date(timeIntervalSinceNow: -1000),
          code: "nc73649170",
          detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!),
    Quake(magnitude: 2.2,
          place: "Rumble Alley",
          time: Date(timeIntervalSinceNow: -5000),
          code: "hv72783692",
          detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/hv72783692")!)
    ]

struct Quakes: View {
    @Environment(QuakesProvider.self) private var quakesProvider
    
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    //@State private var quakes = staticData
    @State private var editMode: EditMode = .inactive
    @State private var selectMode: SelectMode = .inactive
    @State private var isLoading = false
    @State private var selection: Set<String> = []
    @State private var error: QuakeError?
    @State private var hasError = false
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(quakesProvider.quakes) { quake in
                    NavigationLink(destination: QuakeDetail(quake: quake)) {
                        QuakeRow(quake: quake)
                    }
                }
                .onDelete(perform: deleteQuakes)
            }
            .listStyle(.inset)
            .navigationTitle("Earthquakes")
            .refreshable {
                try? await quakesProvider.fetchQuakes()
            }
        }
    }
}

extension Quakes {
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return "Earthquakes"
        } else {
            return "\(selection.count) Selected"
        }
    }

    func deleteQuakes(at offsets: IndexSet) {
        quakesProvider.deleteQuakes(atOffsets: offsets)
    }
    func deleteQuakes(for codes: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in quakesProvider.quakes.enumerated() {
            if codes.contains(element.code) {
                offsetsToDelete.insert(index)
            }
        }
        deleteQuakes(at: offsetsToDelete)
        selection.removeAll()
    }
    func fetchQuakes() async {
        isLoading = true
        do {
            try await quakesProvider.fetchQuakes()
            lastUpdated = Date().timeIntervalSince1970
            isLoading = false
        } catch {
            self.error = error as? QuakeError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        
    }
}



#Preview {
    Quakes()
        .environment(QuakesProvider(client: QuakeClient(downloader: TestDownloader())))
}
