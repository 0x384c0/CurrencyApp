//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Foundation

public struct ExchangeResultModel {
    public init(
        sellAmount: Double,
        sellCurrency: CurrencyModel,
        receiveAmount: Double,
        receiveCurrency: CurrencyModel,
        feeAmount: Double,
        feeCurrency: CurrencyModel
    ) {
        self.sellAmount = sellAmount
        self.sellCurrency = sellCurrency
        self.receiveAmount = receiveAmount
        self.receiveCurrency = receiveCurrency
        self.feeAmount = feeAmount
        self.feeCurrency = feeCurrency
    }

    public let sellAmount: Double
    public let sellCurrency: CurrencyModel
    public let receiveAmount: Double
    public let receiveCurrency: CurrencyModel
    public let feeAmount: Double
    public let feeCurrency: CurrencyModel
}
