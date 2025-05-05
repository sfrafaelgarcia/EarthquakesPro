//
//  SectionView.swift
//  Earthquake
//
//  Created by Rafael Garcia on 5/5/25.
//

import SwiftUI

struct SectionView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.headline)
                .fontWeight(.bold)
            Image(systemName: "star.fill")
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    SectionView()
}
