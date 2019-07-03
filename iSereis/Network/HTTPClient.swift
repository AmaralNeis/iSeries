//
//  HTTPClient.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 29/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation
import Alamofire

class HTTPClient {
    private let typeApi: TypeApi
    
    init(typeApi: TypeApi) {
        self.typeApi = typeApi
    }
    
    func get(url: URLConvertible, parameters: Parameters?) -> DataRequest {
        return request(url: url, method: .get, parameters: parameters, encoding: URLEncoding.default)
    }
    
    func post(url: URLConvertible, parameters: Parameters?) -> DataRequest {
        return request(url: url, method: .post, parameters: parameters)
    }
    
    func delete(url: URLConvertible, parameters: Parameters?) -> DataRequest {
        return request(url: url, method: .delete, parameters: parameters)
    }
    
    private func request(url: URLConvertible, method: HTTPMethod, parameters: Parameters?,
                 encoding: ParameterEncoding = JSONEncoding.default) -> DataRequest {
        return Alamofire.request(url, method: method, parameters: parameters,
                                 encoding: encoding, headers: self.headers())
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
    }
    private func headers() -> HTTPHeaders {
        var headers = ["Accept": "application/json"]
        
        if typeApi == .track {
              headers["trakt-api-version"] = "2"
              headers["trakt-api-key"] = Constants.clientIdTrack
        }
        return headers
    }
}
