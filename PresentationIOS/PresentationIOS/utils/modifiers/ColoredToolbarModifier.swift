//
//  ColoredToolbar.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 8/10/22.
//

import SwiftUI

/// Modifies toolbar color and style
struct ColoredToolbarModifier: ViewModifier {
    let color: Color
    let colorScheme: ColorScheme

    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            return content.toolbarBackground(Color.red, for: .navigationBar)
                .toolbarBackground(color, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(colorScheme, for: .navigationBar)
        } else {
            return content
                .onAppear {
                    UINavigationBarAppearance()
                        .setColor(
                            title: colorScheme == .dark ? UIColor.white : UIColor.black,
                            background: UIColor(color)
                        )
                    UIApplication.shared.statusBarStyle = .lightContent
                }
        }
    }
}

fileprivate extension UINavigationBarAppearance {
    func setColor(title: UIColor, background: UIColor) {
        configureWithTransparentBackground()
        largeTitleTextAttributes = [.foregroundColor: title]
        titleTextAttributes = [.foregroundColor: title]
        backgroundColor = background
        UINavigationBar.appearance().scrollEdgeAppearance = self
        UINavigationBar.appearance().standardAppearance = self
        UINavigationBar.appearance().compactAppearance = self
    }
}
