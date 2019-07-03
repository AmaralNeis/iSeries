//
//  Endpoint.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 29/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//


import Foundation
import Alamofire

class Endpoint {
    
    private let httpClient: HTTPClient
    
    init(type: TypeApi) {
        self.httpClient = HTTPClient(typeApi: type)
    }
    
    func get(url: URLConvertible, parameters: Parameters?, success: @escaping (Int, Any, Any) -> Void,
             failure: @escaping (Int, Any) -> Void) {
        httpClient.get(url: url, parameters: parameters).responseJSON { response in
            self.handleResponse(response: response, success: success, failure: failure)
        }
    }
    
    func readHeaderTrack(header: Any) -> Page {
        guard let dictionary = header as? [String: Any] else {return Page()}
        
        let currentString = dictionary["x-pagination-page"] as! String
        let totalString = dictionary["x-pagination-page-count"] as! String
        return Page(currentPage: Int(currentString) ?? 0, totalPage: Int(totalString) ?? 0)
    }
    
    func handleResponse(response: DataResponse<Any>, success: (Int, [String: AnyObject], Any) -> Void,
                        failure: (Int, Any) -> Void ) {
        let statusCode: Int! = response.response?.statusCode
        
        switch response.result {
        case .success :
            if response.result.value != nil {
                let headers = response.response?.allHeaderFields
                success(statusCode, headers as! [String: AnyObject], response.data ?? "")
            } else {
                failure(statusCode, response)
            }
        case .failure :
            if let statusCode = response.response?.statusCode {
                failure(statusCode, response)
            } else {
                // Network issues
                failure(400, response)
            }
        }
    }
}
