//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Domain

extension CalculateResultModel{
    init(dto:CurrencyExhangeResponseDto){
        self.init(receiveAmount: Double(dto.amount ?? "0") ?? 0)
    }
}
