//
//  ModuleInitializer.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 13/6/22.
//

import Foundation
import Common
import Domain
import Data

protocol ModuleInitializer {
    var modules:[Any] { get set }
}

// should be called once at start app
func initModules() -> [BaseModule] {
    [
        DataModule().register(),
        DomainModule().register(),
    ]
}
