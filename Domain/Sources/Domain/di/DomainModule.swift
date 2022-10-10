//
//  File.swift
//  
//
//  Created by 0x384c0 on 9/10/22.
//

import Foundation
import Common

public class DomainModule: BaseModule {
    public init(){}

    public func register() -> BaseModule {
        DIContainer.shared.register(AccountsInteractor.self) {r in
            AccountsInteractorMockImpl()
        }.inObjectScope(.container)
        DIContainer.shared.register(HistoryInteractor.self) {r in
            HistoryInteractorMockImpl()
        }.inObjectScope(.container)
        DIContainer.shared.register(CurrencyExchangeInteractor.self) {r in
            CurrencyExchangeInteractorImpl(
                remoteDatasource: r.resolve(CurrencyRemoteDataSource.self)!,
                historyInteractor: r.resolve(HistoryInteractor.self)! ,
                accountsInteractor:r.resolve(AccountsInteractor.self)!
            )
        }
        return self
    }
}
