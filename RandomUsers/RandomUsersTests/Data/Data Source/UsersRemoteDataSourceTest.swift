//
//  UsersRemoteDataSourceTest.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 2/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import RxSwift
@testable import RandomUsers

class UsersRemoteDataSourceTest: UsersRemoteDataSourceType {
    private let networkClient: NetworkClient
    var getUsersCalled = false

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getUsers(results: UInt16) -> Single<[UserEntity]> {
        getUsersCalled = true
        return networkClient.requestArray(with: UsersAPIDefinitionTest.list(results: results))
    }
}

// MARK: APIDefinition
private enum UsersAPIDefinitionTest: APIDefinition {
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
            return "results"
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
