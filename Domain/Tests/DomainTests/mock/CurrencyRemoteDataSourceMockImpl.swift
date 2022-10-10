//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Combine
@testable import Domain

class CurrencyRemoteDataSourceMockImpl:CurrencyRemoteDataSource{
    func calculateExchange(sellAmount: Double, sellCurrency: Domain.CurrencyModel, receiveCurrency: Domain.CurrencyModel) -> AnyPublisher<Domain.CalculateResultModel, Error> {
        Just(CalculateResultModel(receiveAmount:sellAmount * 1.5))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
