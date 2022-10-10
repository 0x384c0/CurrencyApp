//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Combine

/// collects and stores transaction history
public protocol HistoryInteractor{

    /// add transaction to history
    ///
    /// - Parameters:
    ///     - transaction: transaction to add in to history
    ///
    /// - Returns: publisher that publishes result of operation
    func addTransaction(transaction:ExchangeResultModel) -> AnyPublisher<Void, TransactionError>

    /// get list of all added transactions
    ///
    /// - Returns: publisher that publishes list of all added transactions
    func getTransactions() -> AnyPublisher<[ExchangeResultModel], Error>
}
