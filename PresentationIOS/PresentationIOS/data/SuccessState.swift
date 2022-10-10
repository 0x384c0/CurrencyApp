//
//  SuccessState.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 9/10/22.
//

import Foundation

struct SuccessState: Identifiable {
    var id: String { String(sellAmount) + sellCurrency + String(receiveAmount) + receiveCurrency + String(feeAmount) + feeCurrency }

    let sellAmount: Double
    let sellCurrency: String
    let receiveAmount: Double
    let receiveCurrency: String
    let feeAmount: Double
    let feeCurrency: String
}
