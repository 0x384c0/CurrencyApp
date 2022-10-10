//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Foundation
import Common
import Domain

public class DataModule: BaseModule {
    public init(){}

    public func register() -> BaseModule {
        DIContainer.shared.register(CurrencyRemoteDataSource.self) {r in
            CurrencyRemoteDataSourceImpl(api: EvpApi())
        }
        return self
    }
}
