//
//  File.swift
//  
//
//  Created by 0x384c0 on 10/10/22.
//

import Foundation
import Combine
import Alamofire

public protocol BaseApi {
    var baseUrl: String { get }
}

public extension BaseApi {
    func createRequest<T: Decodable>(
        path:String,
        parameters: [String: Any]? = nil
    ) -> AnyPublisher<T, Error>{
        print("\(HTTPMethod.get) \(baseUrl + path) \(parameters ?? [:])")
        return AF.request(baseUrl + path)
            .validate()
            .publishDecodable(type: T.self)
            .value()
            .mapError{afError in
                afError as Error
            }
            .eraseToAnyPublisher()
    }
}
