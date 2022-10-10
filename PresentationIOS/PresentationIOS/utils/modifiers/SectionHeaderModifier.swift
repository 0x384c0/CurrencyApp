//
//  SectionHeaderStyle.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 8/10/22.
//

import SwiftUI

struct SectionHeaderModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.secondary)
            .font(.system(size: FontSize.small))
    }
}
