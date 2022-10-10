//
//  Constants.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Foundation

/// stores business logic general configuration
struct DomainConfig {
    static private let FEE_RATE = 0.007
    static private let FREE_TRANSACTIONS = 5

    static func getInitialAccountState() -> [CurrencyModel:AccountModel]{
        [
            CurrencyModel.EUR : AccountModel(amount: 1000, currency: .EUR),
            CurrencyModel.USD : AccountModel(amount: 0, currency: .USD),
            CurrencyModel.JPY : AccountModel(amount: 0, currency: .JPY)
        ]
    }

    static func getAllFees(
        sellAmount:Double,
        transactionCount:Int
    ) -> [FeeRule] {
        [
            ConversionFeeRule(feeRate: FEE_RATE, sellAmount:sellAmount),
            TransactionCountFeeRule(freeTransactions: FREE_TRANSACTIONS, transactionCount:transactionCount)
        ]
    }
}
