//
//  File.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 10/10/22.
//

import Domain

extension ErrorState{
    init(error:Error) {
        if let error = error as? TransactionError{
            switch error {
            case .notEnougFunds: description = "NOT_ENOUG_FUNDS".localized
            case .networkError: description = "NETWORK_ERROR".localized
            case .unknownError: description = "UNKNOWN_ERROR".localized
            }
        } else {
            description = "Error \(error)"
        }
    }
}
