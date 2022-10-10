//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Combine

//TODO: doc
public protocol HistoryInteractor{
    func addTransaction(transaction:ExchangeResultModel) -> AnyPublisher<Void, TransactionError>
    func getTransactions() -> AnyPublisher<[ExchangeResultModel], Error>
}
