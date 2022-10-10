//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Foundation

/// adds some percent of transfer amount fee to transaction
class ConversionFeeRule:FeeRule{
    //MARK: Init
    private let feeRate:Double
    private let sellAmount:Double
    init(feeRate:Double, sellAmount: Double) {
        self.feeRate = feeRate
        self.sellAmount = sellAmount
    }

    //MARK: FeeRule
    var isFree = false
    var amount: Double {
        sellAmount * feeRate
    }
    var isActive:Bool {
        true
    }
}
