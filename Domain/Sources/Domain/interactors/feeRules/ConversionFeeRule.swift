//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Foundation

/// adds 0.7% of transfer amount to transaction
class ConversionFeeRule:FeeRule{
    //MARK: Constants
    private let FEE_RATE = 0.007

    //MARK: Init
    private let sellAmount:Double
    init(sellAmount: Double) {
        self.sellAmount = sellAmount
    }

    //MARK: FeeRule
    var isFree = false
    var amount: Double {
        sellAmount * FEE_RATE
    }
    var isActive:Bool {
        true
    }
}
