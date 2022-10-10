//
//  SuccessStateMapper.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 10/10/22.
//

import Domain

extension SuccessState{
    init(model:ExchangeResultModel){
        self.sellAmount = model.sellAmount
        self.sellCurrency = model.sellCurrency.rawValue
        self.receiveAmount = model.receiveAmount
        self.receiveCurrency = model.receiveCurrency.rawValue
        self.feeAmount = model.feeAmount
        self.feeCurrency = model.feeCurrency.rawValue
    }
}
