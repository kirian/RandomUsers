//
//  APIDefinition.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import Alamofire

protocol APIDefinition {
    var method: Method { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var version: Version { get }
}

extension APIDefinition {
    var parameters: [String: Any]? {
        return nil
    }
    
    var version: Version {
        return .v1
    }
}

enum Method {
    case get, post, put, delete, patch
}

enum Version: String {
    case v1 = "1.1"
}

extension Method {
    // Maps a Framework-agnostic method to Alamofire's HTTP method definitions
    func alamofireMethod() -> Alamofire.HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .delete: return .delete
        case .patch: return .patch
        }
    }
}
