//
//  AccounState.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 10/10/22.
//

import Domain

extension AccounState{
    init(model: AccountModel) {
        label = String(format: "%.2f %@", model.amount, model.currency.rawValue)
    }
}
