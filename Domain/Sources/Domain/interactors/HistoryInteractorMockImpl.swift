//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Combine

class HistoryInteractorMockImpl:HistoryInteractor{
    private var transactions = [ExchangeResultModel]()

    func addTransaction(transaction: ExchangeResultModel) -> AnyPublisher<Void, TransactionError> {
        transactions.append(transaction)
        return Just(Void())
            .setFailureType(to: TransactionError.self)
            .eraseToAnyPublisher()
    }

    func getTransactions() -> AnyPublisher<[ExchangeResultModel], Error> {
        return Just(transactions)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
