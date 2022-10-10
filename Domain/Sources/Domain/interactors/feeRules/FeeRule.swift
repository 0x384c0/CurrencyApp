//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Foundation

///TODO: doc
protocol FeeRule{
    var isFree:Bool { get }
    var isActive:Bool { get }
    var amount:Double { get }
}
