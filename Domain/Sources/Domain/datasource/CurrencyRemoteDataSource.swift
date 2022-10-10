//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Combine

public protocol CurrencyRemoteDataSource{
    func calculateExchange(
        sellAmount:Double,
        sellCurrency:CurrencyModel,
        receiveCurrency:CurrencyModel
    ) -> AnyPublisher<CalculateResultModel, Error> 
}
