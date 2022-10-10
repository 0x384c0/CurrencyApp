//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Combine

class CurrencyExchangeInteractorImpl: CurrencyExchangeInteractor {

    //MARK: init
    init(
        remoteDatasource:CurrencyRemoteDataSource,
        historyInteractor:HistoryInteractor,
        accountsInteractor:AccountsInteractor
    ){
        self.remoteDatasource = remoteDatasource
        self.historyInteractor = historyInteractor
        self.accountsInteractor = accountsInteractor
    }

    let remoteDatasource:CurrencyRemoteDataSource
    let historyInteractor:HistoryInteractor
    let accountsInteractor:AccountsInteractor

    //MARK: CurrenciesInteractor
    func getCurrencies() -> AnyPublisher<[CurrencyModel], Error> {
        Just(CurrencyModel.allCases)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func calculateExchange(
        sellAmount:Double,
        sellCurrency:CurrencyModel,
        receiveCurrency:CurrencyModel
    ) -> AnyPublisher<CalculateResultModel, Error> {
        remoteDatasource.calculateExchange(sellAmount: sellAmount, sellCurrency: sellCurrency, receiveCurrency: receiveCurrency)
    }

    func submitExchange(
        sellAmount:Double,
        sellCurrency:CurrencyModel,
        receiveAmount:Double,
        receiveCurrency:CurrencyModel
    ) -> AnyPublisher<ExchangeResultModel, TransactionError> {
        calculateFee(sellAmount: sellAmount, sellCurrency: sellCurrency)
            .mapError{_ in TransactionError.unknownError}
            .map{ fee in
                ExchangeResultModel(
                    sellAmount: sellAmount,
                    sellCurrency: sellCurrency,
                    receiveAmount: receiveAmount,
                    receiveCurrency: receiveCurrency,
                    feeAmount: fee.amount,
                    feeCurrency: fee.currency
                )
            }
            .flatMap{ [unowned self] exchangeResultModel in
                accountsInteractor
                    .applyTransaction(transaction: exchangeResultModel)
                    .map{exchangeResultModel}
            }
            .flatMap{ [unowned self] exchangeResultModel in
                historyInteractor
                    .addTransaction(transaction: exchangeResultModel)
                    .map{exchangeResultModel}
            }
            .eraseToAnyPublisher()
    }

    //MARK: Fee Calculation
    private func calculateFee(
        sellAmount:Double,
        sellCurrency:CurrencyModel
    ) -> AnyPublisher<FeeModel, Error> {
        historyInteractor
            .getTransactions()
            .map{ [unowned self] in getActiveFees(sellAmount: sellAmount,transactionCount: $0.count)}
            .map{fees in
                if fees.contains(where: {$0.isFree}){
                    return FeeModel(amount: 0,currency: sellCurrency)
                } else {
                    return FeeModel(
                        amount: fees.reduce(0.0, { feeAmount, feeRule in feeAmount + feeRule.amount }),
                        currency: sellCurrency)
                }
            }
            .eraseToAnyPublisher()
    }

    private func getActiveFees(
        sellAmount:Double,
        transactionCount:Int
    ) -> [FeeRule] {
        DomainConfig.getAllFees(sellAmount: sellAmount, transactionCount: transactionCount)
            .filter{$0.isActive}
    }
}
