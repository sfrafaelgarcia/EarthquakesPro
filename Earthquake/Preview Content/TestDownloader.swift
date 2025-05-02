//
//  TestDownloader.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/1/25.
//

import Foundation

final class TestDownloader: HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data {
        try await Task.sleep(for: .milliseconds(.random(in: 100...500)))
        return testQuakesData
    }
}
