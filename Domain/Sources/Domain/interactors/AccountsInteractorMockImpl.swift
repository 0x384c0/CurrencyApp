//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Combine

class AccountsInteractorMockImpl: AccountsInteractor{

    private var accounts = [
        CurrencyModel.EUR : AccountModel(amount: 1000, currency: .EUR),
        CurrencyModel.USD : AccountModel(amount: 0, currency: .USD),
        CurrencyModel.JPY : AccountModel(amount: 0, currency: .JPY)
    ]

    func getAccounts() -> AnyPublisher<[AccountModel], Error> {
        Just(Array(accounts.values))
            .map{$0.sorted { acc1, acc2 in
                CurrencyModel.allCases.firstIndex(of: acc1.currency) ?? 0 < CurrencyModel.allCases.firstIndex(of: acc2.currency) ?? 0
            }}
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func checkTransaction(transaction: ExchangeResultModel) -> AnyPublisher< [CurrencyModel : AccountModel], TransactionError> {
        Just(getAccountsAfterTransactions(transaction: transaction))
            .setFailureType(to: TransactionError.self)
            .flatMap { accounts -> AnyPublisher<[CurrencyModel : AccountModel], TransactionError> in
                if (accounts.values.contains{$0.amount < 0}){
                    return Fail(error: TransactionError.notEnougFunds)
                        .eraseToAnyPublisher()
                } else {
                    return Just(accounts)
                        .setFailureType(to: TransactionError.self)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    func applyTransaction(transaction: ExchangeResultModel) -> AnyPublisher<Void, TransactionError> {
        return checkTransaction(transaction: transaction)
            .map{ [unowned self] newAccounts in
                accounts = newAccounts
            }
            .eraseToAnyPublisher()
    }

    private func getAccountsAfterTransactions(transaction: ExchangeResultModel) -> [CurrencyModel : AccountModel]{
        var accounts = accounts
        if let sellAccount = accounts[transaction.sellCurrency],
           let receiveAccount = accounts[transaction.receiveCurrency]{
            accounts[transaction.sellCurrency] = AccountModel(
                amount: sellAccount.amount - transaction.sellAmount - transaction.feeAmount,
                currency: transaction.sellCurrency
            )
            accounts[transaction.receiveCurrency] = AccountModel(
                amount: receiveAccount.amount + transaction.receiveAmount,
                currency: transaction.receiveCurrency
            )
        }
        return accounts
    }
}
