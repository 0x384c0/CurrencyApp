//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Foundation

/// abstract fee rule
protocol FeeRule{
    /// if true entire transaction will be free
    var isFree:Bool { get }
    /// if true this rule will be applied to transaction
    var isActive:Bool { get }
    /// amount of fee that will be deducted from sell account
    /// > if multiple acive rules exist for transaction they all will be deducted from sell balance
    var amount:Double { get }
}
