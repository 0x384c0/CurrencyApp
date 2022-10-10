//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Foundation

/// makes first N transaction free
class TransactionCountFeeRule:FeeRule {
    //MARK: Init
    private let freeTransactions:Int
    private let transactionCount:Int
    init(freeTransactions:Int,transactionCount: Int) {
        self.freeTransactions = freeTransactions
        self.transactionCount = transactionCount
    }

    //MARK: FeeRule
    var isFree = true
    var amount: Double = 0
    var isActive:Bool {
        transactionCount <= freeTransactions
    }
}
