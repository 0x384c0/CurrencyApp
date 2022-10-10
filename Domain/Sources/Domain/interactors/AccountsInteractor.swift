//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Combine

/// TODO: docs
public protocol AccountsInteractor {
    func getAccounts() -> AnyPublisher<[AccountModel], Error>
    func checkTransaction(transaction:ExchangeResultModel) -> AnyPublisher<[CurrencyModel : AccountModel], TransactionError>
    func applyTransaction(transaction:ExchangeResultModel) -> AnyPublisher<Void, TransactionError>
}
