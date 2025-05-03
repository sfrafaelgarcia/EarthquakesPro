//
//  QuakeClient.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/1/25.
//

import Foundation

actor QuakeClient {
    private let quakeCache: NSCache<NSString, CacheEntryObject> = NSCache()
    
    var quakes: [Quake] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allQuakes = try decoder.decode(GeoJSON.self, from: data)
            var updateQuakes = allQuakes.quakes
            // Fetch the index of the first element with a timestamp greater than one hour
            if let olderThanOneHour = updateQuakes.firstIndex(where: { $0.time.timeIntervalSinceNow > 3600 }) {
                // Range of indices that indictes all the earthquakes in the past hour
                let indexRange = updateQuakes.startIndex..<olderThanOneHour
                // Create a task group that return a value of type (Int, QuakeLocation), which represents the array index and the location
                try await withThrowingTaskGroup(of: (Int, QuakeLocation).self) { group in
                    // Iterate through the indices, and add a task to fetch the location for each quake
                    for index in indexRange {
                        group.addTask {
                            let location = try await self.quakeLocation(from: allQuakes.quakes[index].detail)
                            return (index, location)
                        }
                    }
                    // Wait on each task group
                    while let result = await group.nextResult() {
                        switch result {
                        case .failure(let error):
                            throw error
                        case .success(let (index, location)):
                            updateQuakes[index].location = location
                            
                        }
                    }
                }
            }
            return allQuakes.quakes
        }
    }
    
    private var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    // Fetches and decodes the location
    func quakeLocation(from url: URL) async throws -> QuakeLocation {
        // check for a cache value
        if let cached = quakeCache[url] {
            switch cached {
            case .ready(let location):
                return location
            case .inProgress(let task):
                // Waiting on an inProgress here avoids making a second request.
                return try await task.value
            }
        }
        // task to fetch the location
        let task = Task<QuakeLocation, Error> {
            let data = try await downloader.httpData(from: url)
            let location = try decoder.decode(QuakeLocation.self, from: data)
            return location
        }
        // Store the task in the cache and await the result
        quakeCache[url] = .inProgress(task)
        
        do {
            let location = try await task.value

            // Store the final QuakeLocation in the cache and return the location
            quakeCache[url] = .ready(location)
            return location
            
        } catch {
            quakeCache[url] = nil
            throw error
        }
        
    }
}
