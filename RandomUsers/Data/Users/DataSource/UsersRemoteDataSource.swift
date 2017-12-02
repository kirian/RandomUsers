//
//  UsersRemoteDataSource.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import RxSwift

protocol UsersRemoteDataSourceType {
    func getUsers(results: UInt16) -> Single<[UserEntity]>
}

class UsersRemoteDataSource: UsersRemoteDataSourceType {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getUsers(results: UInt16) -> Single<[UserEntity]> {
        return networkClient.requestArray(with: UsersAPIDefinition.list(results: results))
    }
    
    // MARK: APIDefinition
    private enum UsersAPIDefinition: APIDefinition {
        case list(results: UInt16)
        var method: Method {
            switch self {
            case .list:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .list:
                return ""
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            case .list(let results):
                let parameters = ["results": results] as [String : Any]
                
                return parameters
            }
        }
    }
}
