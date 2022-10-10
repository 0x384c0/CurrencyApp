//
//  File.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 8/10/22.
//

import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.accentColor)
            .clipShape(Capsule())
            .shadow(color: .gray.opacity(0.6), radius: 4, x: 0, y: 2)
            .padding()
    }
}
