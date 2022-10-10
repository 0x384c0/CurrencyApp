import XCTest
import Combine
@testable import Domain

final class CurrencyExchangeInteractorImplTests: BaseXCTestCase<CurrencyExchangeInteractorImpl> {

    //MARK: LifeCycle
    override func setUp() {
        super.setUp()
        sut = CurrencyExchangeInteractorImpl(
            remoteDatasource: CurrencyRemoteDataSourceMockImpl(),
            historyInteractor: HistoryInteractorMockImpl(),
            accountsInteractor: AccountsInteractorMockImpl()
        )
    }

    //MARK: Tests
    func testGotCurrenciesSuccessfull() throws {
        let currencies = waitForPublisher(
            publisher: sut.getCurrencies(),
            description: "GotCurrenciesSuccessfull",
            timeout: 3
        )
        XCTAssertEqual(currencies?.count, CurrencyModel.allCases.count)
    }

    func testCalculateExchangeSuccessfull() throws {
        let currencies = waitForPublisher(
            publisher: sut.calculateExchange(
                sellAmount: 10,
                sellCurrency: .USD,
                receiveCurrency: .EUR
            ),
            description: "CalculateExchangeSuccessfull",
            timeout: 3
        )
        XCTAssertEqual(currencies?.receiveAmount, 15)
    }

    func testSubmitExchangeSuccessfull() throws {
        let currencies = waitForPublisher(
            publisher: sut.submitExchange(
                sellAmount: 10,
                sellCurrency: .EUR,
                receiveAmount: 15,
                receiveCurrency: .USD
            ),
            description: "SubmitExchangeSuccessfull",
            timeout: 3
        )
        XCTAssertEqual(currencies?.sellAmount, 10)
        XCTAssertEqual(currencies?.sellCurrency, CurrencyModel.EUR)
        XCTAssertEqual(currencies?.receiveAmount, 15)
        XCTAssertEqual(currencies?.receiveCurrency, CurrencyModel.USD)
        XCTAssertEqual(currencies?.feeAmount, 0)
    }

    func testSubmitExchangeWithFeeSuccessfull() throws {
        for _ in 0...5{
            let currencies = waitForPublisher(
                publisher: sut.submitExchange(
                    sellAmount: 10,
                    sellCurrency: .EUR,
                    receiveAmount: 15,
                    receiveCurrency: .USD
                ),
                description: "SubmitExchangeWithFeeSuccessfull",
                timeout: 3
            )
            XCTAssertEqual(currencies?.sellAmount, 10)
            XCTAssertEqual(currencies?.sellCurrency, CurrencyModel.EUR)
            XCTAssertEqual(currencies?.receiveAmount, 15)
            XCTAssertEqual(currencies?.receiveCurrency, CurrencyModel.USD)
            XCTAssertEqual(currencies?.feeAmount, 0)
        }
        let currencies = waitForPublisher(
            publisher: sut.submitExchange(
                sellAmount: 10,
                sellCurrency: .EUR,
                receiveAmount: 15,
                receiveCurrency: .USD
            ),
            description: "SubmitExchangeWithFeeSuccessfull",
            timeout: 3
        )
        XCTAssertEqual(currencies?.sellAmount, 10)
        XCTAssertEqual(currencies?.sellCurrency, CurrencyModel.EUR)
        XCTAssertEqual(currencies?.receiveAmount, 15)
        XCTAssertEqual(currencies?.receiveCurrency, CurrencyModel.USD)
        XCTAssertEqual(currencies?.feeAmount, 10 * 0.007)
    }

    func testSubmitExchangeFailed() throws {
        let error = waitForPublisherFail(
            publisher: sut.submitExchange(
                sellAmount: 10,
                sellCurrency: .USD,
                receiveAmount: 15,
                receiveCurrency: .EUR
            ),
            description: "SubmitExchangeFailed",
            timeout: 3
        )
        XCTAssertEqual(error, TransactionError.notEnougFunds)
    }
}
