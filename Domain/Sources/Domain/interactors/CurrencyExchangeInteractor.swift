//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Combine

/// TODO: docs
public protocol CurrencyExchangeInteractor {
    func getCurrencies() -> AnyPublisher<[CurrencyModel], Error>

    func calculateExchange(
        sellAmount:Double,
        sellCurrency:CurrencyModel,
        receiveCurrency:CurrencyModel) -> AnyPublisher<CalculateResultModel, Error>

    func submitExchange(
        sellAmount:Double,
        sellCurrency:CurrencyModel,
        receiveAmount:Double,
        receiveCurrency:CurrencyModel
    ) -> AnyPublisher<ExchangeResultModel, TransactionError>
}
