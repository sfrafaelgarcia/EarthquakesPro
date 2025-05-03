//
//  NSCache+Sunscript.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/2/25.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
    // Subscript that takes an URL and returns an optional CacheEntry
    subscript(_ url: URL) -> CacheEntry? {
        get {
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
                let value = CacheEntryObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
