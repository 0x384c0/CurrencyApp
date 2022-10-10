//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Foundation
import Combine
import Alamofire

class EvpApi: BaseApi {
    let baseUrl = "http://api.evp.lt"

    func getCurrencyExhange(
        fromAmount:String,
        fromCurrency:String,
        toCurrency:String
    ) -> AnyPublisher<CurrencyExhangeResponseDto, Error>{
        createRequest(path: "/currency/commercial/exchange/\(fromAmount)-\(fromCurrency)/\(toCurrency)/latest")
    }
}
