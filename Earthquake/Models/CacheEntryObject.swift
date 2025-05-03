//
//  CacheEntryObject.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/2/25.
//
// Abstract: a class for caching quake data

/*
 NSCache is designed to hold reference types, but an enumeration is a value type. We will create a class to hold an enumeration and insert an instance of this class into the cache.
 */

import Foundation

final class CacheEntryObject {
    let entry: CacheEntry
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

enum CacheEntry {
    case inProgress(Task<QuakeLocation, Error>)
    case ready(QuakeLocation)
}
