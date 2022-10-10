//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Domain
import Combine

/// manages networks requests, authorisation, security checks
class CurrencyRemoteDataSourceImpl: CurrencyRemoteDataSource{
    private let api:EvpApi
    init(api: EvpApi) {
        self.api = api
    }

    func calculateExchange(sellAmount: Double, sellCurrency: CurrencyModel, receiveCurrency: CurrencyModel) -> AnyPublisher<CalculateResultModel, Error> {
        api.getCurrencyExhange(fromAmount: String(sellAmount), fromCurrency: sellCurrency.rawValue, toCurrency: receiveCurrency.rawValue)
            .map{CalculateResultModel(dto:$0)}
            .eraseToAnyPublisher()
    }
}
