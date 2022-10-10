//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import XCTest
import Combine

class BaseXCTestCase<SUT>: XCTestCase{

    //MARK: Sut
    var cancellables = Set<AnyCancellable>()
    var sut:SUT!

    //MARK: LifeCycle
    override func tearDown() {
        super.tearDown()
        cancellables.forEach{$0.cancel()}
        sut = nil
    }





    func waitForPublisher<T,E:Error>(
        publisher:AnyPublisher<T,E>,
        description:String,
        timeout:TimeInterval
    ) -> T?{
        let expectation = expectation(description: description)
        var data:T?
        var error: Error?
        publisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
            } receiveValue: { value in
                data = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: timeout)
        XCTAssertNil(error)
        return data
    }


    func waitForPublisherFail<T,E:Error>(
        publisher:AnyPublisher<T,E>,
        description:String,
        timeout:TimeInterval
    ) -> E?{
        let expectation = expectation(description: description)
        var error: E?
        publisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                expectation.fulfill()
            } receiveValue: { _ in
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: timeout)
        return error
    }
}
