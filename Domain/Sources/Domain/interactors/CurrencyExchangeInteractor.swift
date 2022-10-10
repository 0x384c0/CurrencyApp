//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Combine

/// calculates fee and performs currency exchanges
public protocol CurrencyExchangeInteractor {
    /// get list of all currencies
    ///
    /// - Returns: publisher that publishes list of all currencies
    func getCurrencies() -> AnyPublisher<[CurrencyModel], Error>

    /// calculate receuve amount after currency conversion
    /// > no fees will be calculated
    ///
    /// - Parameters:
    ///     - sellAmount: amount to sell
    ///     - sellCurrency: sell currency
    ///     - receiveCurrency: receive currency
    ///
    /// - Returns: publisher that publishes calculated result of operation
    func calculateExchange(
        sellAmount:Double,
        sellCurrency:CurrencyModel,
        receiveCurrency:CurrencyModel) -> AnyPublisher<CalculateResultModel, Error>

    /// calculate and submit currency conversion
    /// > fees will be calculated and also deducted from sell account
    ///
    /// - Parameters:
    ///     - sellAmount: amount to sell
    ///     - sellCurrency: sell currency
    ///     - receiveAmount: calculated receive amount
    ///     - receiveCurrency: receive currency
    ///
    /// - Returns: publisher that publishes calculated result of operation
    func submitExchange(
        sellAmount:Double,
        sellCurrency:CurrencyModel,
        receiveAmount:Double,
        receiveCurrency:CurrencyModel
    ) -> AnyPublisher<ExchangeResultModel, TransactionError>
}
