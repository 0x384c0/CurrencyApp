//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Foundation

public enum TransactionError:Error{
    case notEnougFunds,
         networkError,
         unknownError
}
