//
//  Quake+Color.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/1/25.
//

import Foundation
import SwiftUI

extension Quake {
    /// The color which corresponds with the quake's magnitude.
    var color: Color {
        switch magnitude {
        case 0..<1:
            return .green
        case 1..<2:
            return .yellow
        case 2..<3:
            return .orange
        case 3..<5:
            return .red
        case 5..<Double.greatestFiniteMagnitude:
            return .init(red: 0.8, green: 0.2, blue: 0.7)
        default:
            return .gray
        }
    }
}
