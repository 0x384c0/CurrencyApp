//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Combine

/// manages user accounts balances
public protocol AccountsInteractor {
    /// get list of all accounts
    ///
    /// - Returns: publisher that publishes list of all accounts
    func getAccounts() -> AnyPublisher<[AccountModel], Error>

    /// check transaction for exisiting accounts
    /// will produce error if not enough funds for operation
    ///
    /// - Parameters:
    ///     - transaction: transaction to check
    ///
    /// - Returns: publisher that publishes list of accounts after operation or error
    func checkTransaction(transaction:ExchangeResultModel) -> AnyPublisher<[CurrencyModel : AccountModel], TransactionError>
    
    /// check transaction for exisiting accounts and applies to accounts
    /// will produce error if not enough funds for operation
    ///
    /// - Parameters:
    ///     - transaction: transaction to apply
    ///
    /// - Returns: publisher that publishes result of operation or error
    func applyTransaction(transaction:ExchangeResultModel) -> AnyPublisher<Void, TransactionError>
}
