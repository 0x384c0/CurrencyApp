//
//  BaseModule.swift
//  PresentationMacOS
//
//  Created by a on 9/5/22.
//

import Foundation

public protocol BaseModule {
    func register() -> BaseModule
}

public extension BaseModule {
    func initialize() {
    }
}
