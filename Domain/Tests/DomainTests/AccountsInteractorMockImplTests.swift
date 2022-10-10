//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import XCTest
import Combine
@testable import Domain

class AccountsInteractorMockImplTests:BaseXCTestCase<AccountsInteractorMockImpl>{
    //MARK: LifeCycle
    override func setUp() {
        super.setUp()
        sut = AccountsInteractorMockImpl()
    }

    //MARK: Tests
    func testCheckTransactionSuccessfull() throws {
        let currencies = waitForPublisher(
            publisher: sut.checkTransaction(transaction: ExchangeResultModel(
                sellAmount: 10,
                sellCurrency: .EUR,
                receiveAmount: 11,
                receiveCurrency: .USD,
                feeAmount: 1,
                feeCurrency: .EUR)
            ),
            description: "CheckTransactionSuccessfull",
            timeout: 3
        )
        XCTAssertEqual(currencies?[.EUR]?.amount, 989.0)
        XCTAssertEqual(currencies?[.USD]?.amount, 11.0)
        XCTAssertEqual(currencies?[.JPY]?.amount, 0.0)
    }


    func testCheckTransactionFailed() throws {
        let error = waitForPublisherFail(
            publisher: sut.checkTransaction(transaction: ExchangeResultModel(
                sellAmount: 10,
                sellCurrency: .USD,
                receiveAmount: 11,
                receiveCurrency: .EUR,
                feeAmount: 1,
                feeCurrency: .USD)
            ),
            description: "CheckTransactionFailed",
            timeout: 3
        )
        XCTAssertEqual(error, TransactionError.notEnougFunds)
    }

}
