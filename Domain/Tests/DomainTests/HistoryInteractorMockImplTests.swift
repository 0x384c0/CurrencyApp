//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import XCTest
import Combine
@testable import Domain

class HistoryInteractorMockImplTests:BaseXCTestCase<HistoryInteractorMockImpl>{
    //MARK: LifeCycle
    override func setUp() {
        super.setUp()
        sut = HistoryInteractorMockImpl()
    }



    //MARK: Tests
    func testAddTransactionSuccessfull() throws {
        let _ = waitForPublisher(
            publisher: sut.addTransaction(transaction: ExchangeResultModel(
                sellAmount: 10,
                sellCurrency: .EUR,
                receiveAmount: 11,
                receiveCurrency: .USD,
                feeAmount: 1,
                feeCurrency: .EUR)
            ),
            description: "AddTransactionSuccessfull",
            timeout: 3
        )
        let transactions = waitForPublisher(
            publisher: sut.getTransactions(),
            description: "GetTransactionSuccessfull",
            timeout: 3
        )
        XCTAssertEqual(transactions?.count, 1)
    }
    
}
