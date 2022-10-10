//
//  PresentationIOSApp.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 8/10/22.
//

import SwiftUI
import Common
import Domain

@main
struct PresentationIOSApp: App, ModuleInitializer {
    init() {
        modules = initModules()
    }

    var modules: [Any]
    var body: some Scene {
        WindowGroup {
            ConverterView(viewModel: ConverterViewModel(
                accountsInteractor: DIContainer.shared.resolve(AccountsInteractor.self)!,
                currencyExchangeInteractor: DIContainer.shared.resolve(CurrencyExchangeInteractor.self)!
            ))
        }
    }
}
