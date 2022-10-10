//
//  NavigationBarModifier.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 8/10/22.
//

import SwiftUI

/// Adds toolbar
struct NavigationBarModifier: ViewModifier {
    let title: String

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("CURRENCY_CONVERTER".localized)
            .navigationBarTitleDisplayMode(.inline)
            .modifier(ColoredToolbarModifier(color: Color.accentColor, colorScheme: .dark))
    }

}
