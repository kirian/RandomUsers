//
//  APIRequest.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import Alamofire

class APIRequest: URLRequestConvertible {
    let baseURL: URL
    let definition: APIDefinition
    
    init(baseURL: URL, definition: APIDefinition) {
        self.baseURL = baseURL
        self.definition = definition
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var urlRequest = URLRequest(url: url.appendingPathComponent(definition.version.rawValue).appendingPathComponent(definition.path))
        urlRequest.httpMethod = definition.method.alamofireMethod().rawValue
        //urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if (definition.method == .get) {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: definition.parameters)
        } else {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: definition.parameters)
        }
        
        return urlRequest
    }
}
