//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Foundation

///TODO: doc
class TransactionCountFeeRule:FeeRule {
    //MARK: Constants
    private let FREE_TRANSACTIONS = 5

    //MARK: Init
    private let transactionCount:Int
    init(transactionCount: Int) {
        self.transactionCount = transactionCount
    }

    //MARK: FeeRule
    var isFree = true
    var amount: Double = 0
    var isActive:Bool {
        transactionCount <= FREE_TRANSACTIONS
    }
}
